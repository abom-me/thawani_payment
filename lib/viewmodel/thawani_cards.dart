


import 'package:thawani_payment/helper/req_helper_new.dart';

import '../models/saveed_cards_model.dart';

class ThawaniCards{

  get({required bool testMode,required String customerId,required String apiKey ,required void Function(Map<String,dynamic>) onError, required  void Function(SavedCardsModel data) onDone,}) async {

    String url = testMode? "https://uatcheckout.thawani.om/api/v1/payment_methods":"https://checkout.thawani.om/api/v1/payment_methods";

   await Request.get(url: "$url?customer_id=$customerId", headers:  {'Content-Type':"application/json", 'thawani-api-key':apiKey}).then((value) {
      if(value['code']==2000){
        onDone(SavedCardsModel.fromJson(value));
      }else{
        onError(value);
      }
    });
  }



}