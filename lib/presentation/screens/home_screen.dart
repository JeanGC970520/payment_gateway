import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:payment_gateway/presentation/blocs/cubit/user_form_cubit.dart';
import 'package:payment_gateway/presentation/blocs/payment_gateway/payment_gateway_bloc.dart';
import 'package:payment_gateway/presentation/views/paypal_payment.dart';
import 'package:payment_gateway/presentation/widgets/inputs/reusable_text_form_field.dart';
import 'package:payment_gateway/presentation/widgets/shared/reusable_box_decoration.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  static const List<String> currencyList = <String>[
    'USD',
    'EUR',
    'MXN',
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Body(currencyList: currencyList),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.currencyList,
  });

  final List<String> currencyList;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final userFormCubit = context.watch<UserFormCubit>();
    final paymentGatewayBloc = context.read<PaymentGatewayBloc>();

    return SingleChildScrollView(
      child: Column(
        children: [
      
          Image.asset(
            'assets/images/donate.jpg',
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
      
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
      
                const Text(
                  'Support with your donations',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
      
                const SizedBox(height: 12,),
      
                Row(
                  children: [
      
                    Expanded(
                      flex: 5,
                      child: ReusableTextFormField(
                        label: 'Donation Amount',
                        hintText: 'Any amount you like',
                        prefixIcon: const Icon(CupertinoIcons.money_dollar, size: 32,),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.]*')),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20,),
      
                    ReusableBoxDecoration(
                      horizontalPadding: 10,
                      child: SizedBox(
                        height: size.height * 0.07,
                        child: DropdownMenu<String>(
                          inputDecorationTheme: const InputDecorationTheme(
                            border: InputBorder.none,
                            labelStyle: TextStyle(fontSize: 20),
                            hintStyle: TextStyle(fontSize: 20),
                            floatingLabelStyle: TextStyle(fontSize: 20),
                          ),
                          textStyle: const TextStyle(fontSize: 25),
                          initialSelection: currencyList.first,
                          onSelected: (value) {
                            debugPrint(value);
                          },
                          dropdownMenuEntries: currencyList.map<DropdownMenuEntry<String>>(
                            (currency) => DropdownMenuEntry(
                              value: currency, label: currency,
                            )
                          ).toList(),
                        ),
                      ),
                    ),
      
                  ],
                ),
                const SizedBox(height: 12,),
      
                ReusableTextFormField(
                  label: 'Name',
                  hintText: 'Ex. John Doe',
                  prefixIcon: const Icon(CupertinoIcons.person_alt, size: 32,),
                  onChanged: userFormCubit.nameChange,
                  errorMessage: userFormCubit.state.name.errorMessage,
                ),
                const SizedBox(height: 12,),
      
                ReusableTextFormField(
                  label: 'Adress Line',
                  hintText: 'Ex. 123 Main St.',
                  prefixIcon: const Icon(Icons.pin_drop, size: 32,),
                  onChanged: userFormCubit.addressChange,
                  errorMessage: userFormCubit.state.address.errorMessage,
                ),
                const SizedBox(height: 12,),
      
                Row(
                  children: [
                    
                    Expanded(
                      flex: 5,
                      child: ReusableTextFormField(
                        label: 'City',
                        hintText: 'Ex. New Delhi',
                        prefixIcon: const Icon(Icons.location_city_rounded, size: 32,),
                        onChanged: userFormCubit.cityChange,
                        errorMessage: userFormCubit.state.city.errorMessage,
                      ),
                    ),
      
                    const SizedBox(width: 20,),
      
                    Expanded(
                      flex: 5,
                      child: ReusableTextFormField(
                        label: 'State',
                        hintText: 'Ex. DL',
                        prefixIcon: const Icon(CupertinoIcons.map, size: 32,),
                        onChanged: userFormCubit.stateInputChange,
                        errorMessage: userFormCubit.state.stateInput.errorMessage,
                      ),
                    ),
      
                  ],
                ),
                const SizedBox(height: 12,),
      
                Row(
                  children: [
                    
                    Expanded(
                      flex: 5,
                      child: ReusableTextFormField(
                        label: 'Country',
                        hintText: 'Ex. MX for Mexico',
                        prefixIcon: const Icon(Icons.abc, size: 32,),
                        onChanged: userFormCubit.countryChange,
                        errorMessage: userFormCubit.state.country.errorMessage,
                      ),
                    ),
      
                    const SizedBox(width: 20,),
      
                    Expanded(
                      flex: 5,
                      child: ReusableTextFormField(
                        label: 'Zipcode',
                        hintText: 'Ex. 09876',
                        prefixIcon: const Icon(CupertinoIcons.number_square, size: 32,),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]+')),
                        ],
                        onChanged: userFormCubit.zipcodeChange,
                        errorMessage: userFormCubit.state.zipcode.errorMessage,
                      ),
                    ),
      
                  ],
                ),
                const SizedBox(height: 25,),
    
                SizedBox(
                  height: size.height * 0.065,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      userFormCubit.onSubmit();
    
                      if( !userFormCubit.state.isValid ) return;
    
                      final user = userFormCubit.getUser();
                      debugPrint(user.toString());

                      paymentGatewayBloc.add(
                        MakePaymentEvent(
                          amount: '10', 
                          currency: 'usd', 
                          userInfo: user,
                          description: 'Pet\'s Donation'
                        ),
                      );
    
                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.shade200,
                      foregroundColor: Colors.white.withAlpha(230)
                    ),
                    icon: const Icon(CupertinoIcons.money_dollar_circle, size: 35,), 
                    label: const Text('Proced to pay', style: TextStyle(fontSize: 27),),
                  ),
                ),

                const SizedBox(height: 25,),

                SizedBox(
                  height: size.height * 0.065,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const PayPalPayment(),)
                      );
                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 251, 9),
                      foregroundColor: Colors.black.withAlpha(230)
                    ),
                    icon: Image.asset(
                      'assets/images/paypal.png',
                      scale: 6.0,
                    ), 
                    label: const Text('Pay with PayPal', style: TextStyle(fontSize: 27),),
                  ),
                ),
                
              ],
            ),
          ),
      
        ],
      ),
    );
  }
}