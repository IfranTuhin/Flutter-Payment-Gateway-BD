
import 'dart:developer';

import 'package:bkash/bkash.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uddoktapay/models/customer_model.dart';
import 'package:uddoktapay/models/request_response.dart';
import 'package:uddoktapay/uddoktapay.dart';

void onButtonTap(String selected, BuildContext context) async {
  switch (selected) {
    case 'bkash':
      bkashPayment(context);
      break;
    case 'UddoktaPay': uddoktaPay(context: context);
      break;
    default: log('No Payment Gateway Selected');
  }
}

double totalPrice = 10.00;

// bKash payment gateway
final bkash = Bkash(logResponse: true);
void bkashPayment(context) async {
  try {
    final response = await bkash.pay(
      context: context,
      amount: totalPrice,
      merchantInvoiceNumber: 'Test0123456',
    );
    log('Transaction Id : ${response.trxId}');
    log('Payment Id : ${response.paymentId}');
  } on BkashFailure catch  (e) {
    log('Bkash Message : ${e.message}');
  }
}

// Uddokta Pay
void uddoktaPay({required BuildContext context}) async{
  final response = await UddoktaPay.createPayment(
    context: context,
    customer: CustomerDetails(fullName: 'Ifran Hossen Tuhin', email: 'ifranhossentuhin@gmail.com'),
    amount: totalPrice.toString(),
  );

  if(response.status == ResponseStatus.completed) {
    log('Payment Completed, Trx Id : ${response.transactionId}');
  } else if(response.status == ResponseStatus.canceled) {
    log('Uddokta Payment Canceled');
  } else if(response.status == ResponseStatus.pending) {
    log('Uddokta Payment Pending');
  }
}