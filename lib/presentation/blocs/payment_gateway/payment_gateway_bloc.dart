import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gateway/logger.dart';

import '../../../domain/entities/user.dart';

part 'payment_gateway_event.dart';
part 'payment_gateway_state.dart';

class PaymentGatewayBloc extends Bloc<PaymentGatewayEvent, PaymentGatewayState> {

  final dioStripe = Dio(
    BaseOptions(baseUrl: 'https://api.stripe.com/v1'),
  );
  
  PaymentGatewayBloc() : super(const PaymentGatewayState()) {
    on<MakePaymentEvent>(_mapMakePaymentEventToState);
  }

  Future<Map<dynamic, dynamic>?> createPaymentIntent({
    required String amount, 
    required String currency,
    required User userInfo,
    required String description,
  }) async { 
    try { 
      Map<String, dynamic> body = { 
        'amount': ((int.parse(amount)) * 100).toString(), 
        'currency': currency, 
        'payment_method_types[]': 'card', 
        'description' : description,
        'shipping[name]' : userInfo.name,
        'shipping[address][line1]' : userInfo.address,
        'shipping[address][postal_code]' : userInfo.zipcode,
        'shipping[address][city]' : userInfo.city,
        'shipping[address][state]' : userInfo.stateCode,
        'shipping[address][country]' : userInfo.countryCode,
      }; 

      dioStripe.options.headers = { 
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}', 
          'Content-Type': 'application/x-www-form-urlencoded'
      };
      final response = await dioStripe.post( 
        '/payment_intents', 
        data: body, 
      ); 

      // logger.d('Payment Intent Body: ${response.data.toString()}');
      return response.data; 
    } catch (err) { 
      logger.e('Error charging user: ${err.toString()}'); 
      return null;
    } 
  }

  Future<void> initPaymentIntent(Map<dynamic, dynamic> data) async {
    debugPrint('Initializating payment sheet');
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        // Set to true for custom flow
        customFlow: false,
        // Main params
        merchantDisplayName: 'Flutter Stripe Store demo',
        paymentIntentClientSecret: data['client_secret'],
        // Customer keys
        // customerEphemeralKeySecret: data['ephemeralKey'],
        customerId: data['id'],
        style: ThemeMode.dark,
        // appearance: const PaymentSheetAppearance(
        //   colors: PaymentSheetAppearanceColors(
        //     background: Colors.lightBlue,
        //     primary: Colors.blue,
        //     componentBorder: Colors.red,
        //   ),
        //   shapes: PaymentSheetShape(
        //     borderWidth: 4,
        //     shadow: PaymentSheetShadowParams(color: Colors.red),
        //   ),
        //   primaryButton: PaymentSheetPrimaryButtonAppearance(
        //     shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
        //     colors: PaymentSheetPrimaryButtonTheme(
        //       light: PaymentSheetPrimaryButtonThemeColors(
        //         background: Color.fromARGB(255, 231, 235, 30),
        //         text: Color.fromARGB(255, 235, 92, 30),
        //         border: Color.fromARGB(255, 235, 92, 30),
        //       ),
        //     ),
        //   ),
        // ), 
      )
    );
    logger.i("Payment sheet it's ready");
  }

  Future<bool> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } on StripeException catch (err) {
      logger.e('Error on present payment sheet: $err');
      return false;
    }
  }

  void _mapMakePaymentEventToState(
    MakePaymentEvent event, Emitter<PaymentGatewayState> emit
  ) async {
    final response = await createPaymentIntent(
      amount: event.amount, 
      currency: event.currency,
      userInfo: event.userInfo,
      description: event.description,
    );
    logger.d(response?.values.toString());

    // If create paymenent intent is not success.
    if(response == null) return;

    await initPaymentIntent(response);

    final paymentStatus = await presentPaymentSheet();
    logger.i('Payment status: $paymentStatus');
  }

}
