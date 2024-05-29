import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  Future<Map<dynamic, dynamic>?> createPaymentIntent(String amount, String currency) async { 
    try { 
      Map<String, dynamic> body = { 
        'amount': ((int.parse(amount)) * 100).toString(), 
        'currency': currency, 
        'payment_method_types[]': 'card', 
      }; 

      dioStripe.options.headers = { 
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}', 
          'Content-Type': 'application/x-www-form-urlencoded'
      };
      final response = await dioStripe.post( 
        '/payment_intents', 
        data: body, 
      ); 

      debugPrint('Payment Intent Body: ${response.data.toString()}');
      return response.data; 
    } catch (err) { 
      debugPrint('Error charging user: ${err.toString()}'); 
      return null;
    } 
  } 

  void _mapMakePaymentEventToState(
    MakePaymentEvent event, Emitter<PaymentGatewayState> emit
  ) async {
    final response = await createPaymentIntent(event.amount, event.currency);
    debugPrint(response?.values.toString());
  }

}
