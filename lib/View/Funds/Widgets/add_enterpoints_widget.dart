
import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';

class AddEnterPointsWidget extends StatelessWidget {
  const AddEnterPointsWidget({
    super.key,
    required this.addPointsButton,
    required this.pointsController,
  });

  final List<String> addPointsButton;
  final TextEditingController pointsController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: addPointsButton.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 5.0),
            child: ElevatedButton(
              onPressed: () {
                pointsController.text =
                    addPointsButton[index];
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5, vertical: 2),
                  minimumSize: const Size(70, 25),
                  maximumSize: const Size(70, 25),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  foregroundColor: kWhiteColor,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: kWhiteColor,
                      width: 1,
                    ),
                    borderRadius: kMediumBorderRadius,
                  )),
              child: Text(addPointsButton[index]),
            ),
          );
        },
      ),
    );
  }
}
