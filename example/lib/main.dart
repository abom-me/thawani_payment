import 'package:flutter/material.dart';
import 'package:thawani_payment/widgets/pay_button.dart';

import 'v.dart';

import 'c.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Thawani Payment Example'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 50,
              child: ThawaniPayBtn(
                testMode: true,
                api: 'rRQ26GcsZzoEhbrP2HZvLYDbn9C9et',
                pKey: 'HGvTMLDssJghr9tlN9gr4DVYt0qyBy',
                clintID: '1234',
                onError: (e) {
                  print(e);
                },
                products: const [
                  {"name": "product 1", "quantity": 1, "unit_amount": 1000},
                  {"name": "product 2", "quantity": 1, "unit_amount": 200}
                ],
                onCreate: (v) {
                  // print(create as Map);
                },
                onCancelled: (v) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (builder) => C()));
                },
                onPaid: (v) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (builder) => V()));
                },
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  //  getRequest() async{
  //    var body={
  //      "client_reference_id": "123412",
  //      "mode": "payment",
  //      "products": [
  //        {
  //          "name": "product 1",
  //          "quantity": 1,
  //          "unit_amount": 1000
  //        }
  //      ],
  //      "success_url": "https://company.com/done",
  //      "cancel_url": "https://company.com/cancel",
  //      "metadata": {
  //        "Customer name": "somename",
  //        "order id": 0
  //      }
  //    };
  //    print("sart");
  //    var url2 = Uri.parse('https://uatcheckout.thawani.om/api/v1/checkout/session');
  // var response=await http.post(url2,
  //
  //        headers: {'thawani-api-key': 'rRQ26GcsZzoEhbrP2HZvLYDbn9C9et','Content-Type':'application/json'},
  //
  //
  //        body:  json.encode(body));
  //    try{
  //      if(response.statusCode==200){
  //        String data=response.body;
  //        var decodeData=jsonDecode(data);
  //
  //        print(decodeData);
  //       Navigator.push(context, MaterialPageRoute(builder: (builder)=>PayWidget(uri: decodeData['data']['session_id'],)));
  //
  //      }
  //      else{
  //        return'failed';
  //      }
  //    }catch(e){
  //      return 'failed';
  //    }
  //
  //  }
}
