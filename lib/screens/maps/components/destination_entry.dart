import 'package:flutter/material.dart';
import 'package:uber_clone/screens/home/components/recents.dart';
import 'package:uber_clone/screens/home/components/search_field.dart';
import 'package:uber_clone/services/global_model.dart';

class DestinationEntry extends StatelessWidget {
  final GlobalModel model;
  final PageController pageController;

  const DestinationEntry(
      {Key? key, required this.model, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SearchField(
                  model: model,
                  fromSource: false,
                  pageController: pageController),
              Recents(model: model),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          left: 10,
          right: 10,
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    style: TextButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                    },
                    icon: const Icon(Icons.time_to_leave_outlined,
                        color: Colors.white),
                    label: const Text(
                      "Ride",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.local_dining, color: Colors.black),
                    label: const Text(
                      "Eats",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
