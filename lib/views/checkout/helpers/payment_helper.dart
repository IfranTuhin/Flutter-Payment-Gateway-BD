
import 'dart:developer';

import 'package:bkash/bkash.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void onButtonTap(String selected, BuildContext context) async {
  switch (selected) {
    case 'bkash':
      bkashPayment(context);
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