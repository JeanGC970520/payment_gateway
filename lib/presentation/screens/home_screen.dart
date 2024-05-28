import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: SingleChildScrollView(
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
        
                  const ReusableTextFormField(
                    label: 'Name',
                    hintText: 'Ex. John Doe',
                    prefixIcon: Icon(CupertinoIcons.person_alt, size: 32,),
                  ),
                  const SizedBox(height: 12,),
        
                  const ReusableTextFormField(
                    label: 'Adress Line',
                    hintText: 'Ex. 123 Main St.',
                    prefixIcon: Icon(Icons.pin_drop, size: 32,),
                  ),
                  const SizedBox(height: 12,),
        
                  const Row(
                    children: [
                      
                      Expanded(
                        flex: 5,
                        child: ReusableTextFormField(
                          label: 'City',
                          hintText: 'Ex. New Delhi',
                          prefixIcon: Icon(Icons.location_city_rounded, size: 32,),
                        ),
                      ),
        
                      SizedBox(width: 20,),
        
                      Expanded(
                        flex: 5,
                        child: ReusableTextFormField(
                          label: 'State',
                          hintText: 'Ex. DL',
                          prefixIcon: Icon(CupertinoIcons.map, size: 32,),
                        ),
                      ),
        
                    ],
                  ),
                  const SizedBox(height: 12,),
        
                  Row(
                    children: [
                      
                      const Expanded(
                        flex: 5,
                        child: ReusableTextFormField(
                          label: 'Country',
                          hintText: 'Ex. MX for Mexico',
                          prefixIcon: Icon(Icons.abc, size: 32,),
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
                        
                      }, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.shade400,
                        foregroundColor: Colors.white.withAlpha(230)
                      ),
                      icon: const Icon(CupertinoIcons.money_dollar_circle, size: 35,), 
                      label: const Text('Proced to pay', style: TextStyle(fontSize: 27),),
                    ),
                  )
                  
                ],
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}