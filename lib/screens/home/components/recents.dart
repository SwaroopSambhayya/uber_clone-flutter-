import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uber_clone/services/global_model.dart';

class Recents extends StatefulWidget {
  final GlobalModel model;
  const Recents({Key? key, required this.model}) : super(key: key);

  @override
  _RecentsState createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: widget.model.recents.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Recents",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                ...widget.model.recents.map(
                  (ele) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.history,
                        size: 28,
                        color: Colors.grey[600],
                      ),
                    ),
                    title: Text(ele.description.toString()),
                  ),
                )
              ],
            )
          : Container(),
    );
  }
}
