import 'package:flutter/material.dart';

class C extends StatefulWidget {
  const C({Key? key}) : super(key: key);

  @override
  State<C> createState() => _CState();
}

class _CState extends State<C> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelled')),
      ),
    );
  }
}
