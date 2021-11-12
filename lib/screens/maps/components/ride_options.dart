import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:uber_clone/services/global_model.dart';

class RideOptions extends StatefulWidget {
  final GlobalModel model;
  final PageController pageController;
  const RideOptions(
      {Key? key, required this.model, required this.pageController})
      : super(key: key);

  @override
  _RideOptionsState createState() => _RideOptionsState();
}

class _RideOptionsState extends State<RideOptions> {
  Map<String, dynamic> selectedRide = {};
  List rideOptions = [
    {"id": "123", "name": "UberX", "price": 25, "img": "assets/UberX.webp"},
    {"id": "456", "name": "UberXL", "price": 35, "img": "assets/UberXL.webp"},
    {"id": "789", "name": "UberLUX", "price": 55, "img": "assets/Lux.webp"},
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: widget.model.processing
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            widget.pageController.animateToPage(0,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Expanded(
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: Text(
                                "Select Ride     ${(double.parse(widget.model.travelTimeInfo?['miles'].split(' ')[0]) * 1.60934).round()}km",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      child: Column(
                          children: rideOptions
                              .map(
                                (e) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedRide = e;
                                    });
                                  },
                                  child: Container(
                                    color: e == selectedRide
                                        ? Colors.grey[400]
                                        : Colors.transparent,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          e["img"],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              e["name"],
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              widget.model.travelTimeInfo?[
                                                  'travelTime'],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[800]),
                                            )
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            "₹" +
                                                widget.model
                                                    .calculatePrice(e['price']),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList()),
                    )
                  ],
                ),
        ),
        if (selectedRide.isNotEmpty)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Book",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
      ],
    );
  }
}
