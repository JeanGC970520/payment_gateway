import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payment_gateway/presentation/widgets/inputs/reusable_text_form_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Image.asset(
            'assets/images/donate.jpg',
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),

          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'Support with your donations',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 12,),

                ReusableTextFormField(
                  label: 'Donation Amount',
                  hintText: 'Any amount you like',
                  prefixIcon: Icon(CupertinoIcons.money_dollar, size: 32,),
                ),
                SizedBox(height: 12,),

                ReusableTextFormField(
                  label: 'Donation Amount',
                  hintText: 'Any amount you like',
                  prefixIcon: Icon(CupertinoIcons.money_dollar, size: 32,),
                ),
                SizedBox(height: 12,),

                ReusableTextFormField(
                  label: 'Donation Amount',
                  hintText: 'Any amount you like',
                  prefixIcon: Icon(CupertinoIcons.money_dollar, size: 32,),
                ),
                SizedBox(height: 12,),

                ReusableTextFormField(
                  label: 'Donation Amount',
                  hintText: 'Any amount you like',
                  prefixIcon: Icon(CupertinoIcons.money_dollar, size: 32,),
                ),
                SizedBox(height: 12,),
                
              ],
            ),
          ),

        ],
      ),
    );
  }
}