
import 'dart:convert';
import 'package:http/http.dart' as http;
class RequestHelper{
  static Future getRequest(String session,api) async{
    var url = Uri.parse('https://uatcheckout.thawani.om/api/v1/checkout/session/$session');
    http.Response response=await http.get(url,

      headers: {'thawani-api-key': api,'Content-Type':'application/json'},);

    try{
      if(response.statusCode==200){
        String data=response.body;
        var decodeData=jsonDecode(data);
        return decodeData;
      }
      else{
        return'failed';
      }
    }catch(e){
      return 'failed';
    }

  }

  static Future postRequest(String api,Map body,bool testMood) async{

    var url2 =testMood==true? Uri.parse('https://uatcheckout.thawani.om/api/v1/checkout/session'):Uri.parse('https://checkout.thawani.om/api/v1/checkout/session');
    http.Response response=await http.post(url2,

        headers: {'thawani-api-key': api,'Content-Type':'application/json'},


        body:  json.encode(body));


    try{
      if(response.statusCode==200){
        String data=response.body;
        var decodeData=jsonDecode(data);
        // print(decodeData);
        return decodeData;
      }
      else{
        var data=response.body;
        var decodeData=jsonDecode(data);
        // print(decodeData);
       return decodeData;
      }
    }catch(e){
      return 'failed';
    }

  }

}