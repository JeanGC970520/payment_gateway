import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

import '../../logger.dart';

class PayPalPayment extends StatelessWidget {
  const PayPalPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return UsePaypal(
      sandboxMode: true,
      clientId: dotenv.env['PAYPAL_SANDBOX_CLIENT_ID']!,
      secretKey: dotenv.env['PAYPAL_SANDBOX_SECRET_KEY']!,
      returnURL: 'com.jeanpoolgarcia.paymentgateway://paypalpay',
      cancelURL: 'https://samplesite.com/cancel',
      transactions: const [
        {
          "amount": {
            "total": '10.12',
            "currency": "USD",
            "details": {
              "subtotal": '10.12',
              "shipping": '0',
              "shipping_discount": 0
            }
          },
          "description":
              "The payment transaction description.",
          // "payment_options": {
          //   "allowed_payment_method":
          //       "INSTANT_FUNDING_SOURCE"
          // },
          "item_list": {
            "items": [
              {
                "name": "A demo product",
                "quantity": 1,
                "price": '10.12',
                "currency": "USD"
              }
            ],

            // shipping address is not required though
            "shipping_address": {
              "recipient_name": "Jane Foster",
              "line1": "Travis County",
              "line2": "",
              "city": "Austin",
              "country_code": "US",
              "postal_code": "73301",
              "phone": "+00000000",
              "state": "Texas"
            },
          }
        }
      ],
      note: 'Payment with Paypal',
      onSuccess: (Map params) {
        logger.i('Paypal payment sucess: $params');
      },
      onError: (err) {
        logger.e('PayPal error $err');
      },
      onCancel: (params) {
        logger.d('PayPal payment cancel: $params');
      },
    );
  }
}