import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/screens/home/home.dart';
import 'package:uber_clone/services/global_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => GlobalModel(), child: const UberClone()));
}

class UberClone extends StatelessWidget {
  const UberClone({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}
