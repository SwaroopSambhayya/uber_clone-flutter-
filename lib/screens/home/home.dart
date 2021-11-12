import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/screens/home/components/search_field.dart';
import 'package:uber_clone/services/global_model.dart';

import 'components/nav_options.dart';
import 'components/recents.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data = [
    {
      "imgSrc": "assets/UberX.webp",
      "title": "Book a ride",
      "navigatTo": "MapScreen"
    },
    {
      "imgSrc": "assets/food.png",
      "title": "Order Food",
      "navigatTo": "MapScreen"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer<GlobalModel>(builder: (context, model, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(20).copyWith(top: 40),
                  child: Image.asset(
                    'assets/uber.png',
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SearchField(model: model),
                Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Row(
                    children: [
                      ...data.map(
                        (ele) => NavOptions(
                          title: ele["title"].toString(),
                          imgSrc: ele["imgSrc"].toString(),
                          navigateTo: ele["navigateTo"].toString(),
                        ),
                      )
                    ],
                  ),
                ),
                Recents(
                  model: model,
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
