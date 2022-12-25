import 'package:flutter/material.dart';

class V extends StatefulWidget {
  const V({Key? key}) : super(key: key);

  @override
  State<V> createState() => _VState();
}

class _VState extends State<V> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Paid'),

          ],
        ),
      ),
    );
  }
}
