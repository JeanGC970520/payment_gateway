part of 'payment_gateway_bloc.dart';

sealed class PaymentGatewayEvent extends Equatable {
  const PaymentGatewayEvent();

  @override
  List<Object> get props => [];
}

class MakePaymentEvent extends PaymentGatewayEvent {

  final String amount;
  final String currency;
  final User userInfo;

  const MakePaymentEvent({
    required this.amount, 
    required this.currency, 
    required this.userInfo,
  });
}