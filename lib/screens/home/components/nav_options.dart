import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/screens/maps/view.dart';
import 'package:uber_clone/services/global_model.dart';

class NavOptions extends StatefulWidget {
  final String imgSrc;
  final String title;
  final String navigateTo;

  const NavOptions(
      {this.imgSrc = "", this.title = "", this.navigateTo = "", Key? key})
      : super(key: key);

  @override
  State<NavOptions> createState() => _NavOptionsState();
}

class _NavOptionsState extends State<NavOptions> {
  navigateToMapScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MapsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(builder: (context, model, child) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            model.addToRecents();
            if (model.getOrigin != null) navigateToMapScreen();
          },
          child: Opacity(
            opacity: model.getOrigin == null ? 0.5 : 1,
            child: Card(
              color: Colors.grey[300],
              elevation: 0,
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        widget.imgSrc,
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25, left: 10),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: 10),
                      child: const CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
