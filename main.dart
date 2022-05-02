// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const customSwatch = MaterialColor(
    0xFFFF5252,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFFF5252),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wake Lock"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // The following code will enable the wakelock on the device
                // using the wakelock plugin.
                setState(() {
                  Wakelock.enable();
                  // You could also use Wakelock.toggle(on: true);
                });
              },
              child: const Text('enable wakelock'),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                // The following code will disable the wakelock on the device
                // using the wakelock plugin.
                setState(() {
                  Wakelock.disable();
                  // You could also use Wakelock.toggle(on: false);
                });
              },
              child: const Text('disable wakelock'),
            ),
            SizedBox(height: 20,),
            FutureBuilder(
              future: Wakelock.enabled,
              builder: (context, AsyncSnapshot<bool> snapshot) {
                final data = snapshot.data;
                // The use of FutureBuilder is necessary here to await the
                // bool value from the `enabled` getter.
                if (data == null) {
                  // The Future is retrieved so fast that you will not be able
                  // to see any loading indicator.
                  return Container();
                }
                return Text('The wakelock is currently ${data ? 'enabled' : 'disabled'}.');
              },
            ),
          ],
        ),
      ),
    );
  }
}

