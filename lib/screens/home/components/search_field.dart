import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:uber_clone/key.dart';
import 'package:uber_clone/services/global_model.dart';
import 'package:uber_clone/services/location.dart' as loc;

class SearchField extends StatefulWidget {
  final GlobalModel? model;
  final bool fromSource;
  final PageController? pageController;
  const SearchField(
      {Key? key,
      @required this.model,
      this.fromSource = true,
      this.pageController})
      : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  // ignore: unused_field
  TextEditingController textEditingController = TextEditingController();
  List<AutocompletePrediction>? predictions = [];
  var googlePlace = GooglePlace(GOOGLE_MAPS_KEY);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          TextField(
            controller: textEditingController,
            onChanged: (val) async {
              if (val.length > 3) {
                await Future.delayed(const Duration(milliseconds: 600));
                AutocompleteResponse? result =
                    await googlePlace.autocomplete.get(val);
                predictions = result?.predictions;
              }
              setState(() {});
            },
            decoration: InputDecoration(
              filled: true,
              fillColor:
                  widget.fromSource ? Colors.transparent : Colors.grey[200],
              hintText: widget.fromSource ? "Where From?" : "Where To?",
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              suffix: textEditingController.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        textEditingController.clear();
                        setState(() {
                          predictions = [];
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey[100]),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
          if (predictions!.length > 1)
            SizedBox(
              height: 200,
              child: ListView.separated(
                itemCount: predictions!.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey[300],
                  );
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      textEditingController.text =
                          predictions![index].description.toString();
                      DetailsResponse? response = await googlePlace.details
                          .get(predictions![index].placeId!);
                      Map<String, dynamic> data = {
                        "lat": response?.result?.geometry?.location?.lat,
                        "long": response?.result?.geometry?.location?.lng,
                        "description": predictions?[index].description
                      };
                      if (widget.fromSource) {
                        widget.model!.setOrigin(
                          loc.Location.fromJson(data),
                        );
                      } else {
                        widget.model!.setDestination(
                          loc.Location.fromJson(data),
                        );
                        widget.pageController!.animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      }
                      setState(() {
                        predictions = [];
                      });
                      FocusScope.of(context).unfocus();
                    },
                    title: Text(predictions![index].description.toString()),
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
