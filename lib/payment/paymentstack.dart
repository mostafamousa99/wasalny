import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_live_location_gmap/constants/publickey.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class Makepayment {
  int price;
  BuildContext ctx;
  String email;

  Makepayment({this.ctx, this.price, this.email});
  PaystackPlugin paystackPlugin = PaystackPlugin();
  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future intilazepayment() async {
    await paystackPlugin.initialize(publicKey: Publickey.paykey);
  }

  Chargecard() async {
    intilazepayment().then((_) async {
      Charge charge = Charge()
        ..amount = price * 100
        ..email = email
        ..reference = _getReference()
        ..card = getcardui();
      CheckoutResponse response = await paystackPlugin.checkout(ctx,
          charge: charge, method: CheckoutMethod.card, fullscreen: false);
      if (response.status == true) {
        print("yes");
      }
    });
  }

  PaymentCard getcardui() {
    return PaymentCard(number: "", cvc: "", expiryMonth: 0, expiryYear: 0);
  }
}
