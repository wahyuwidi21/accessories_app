import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({super.key, required this.title, required this.desc});
  final String title;
  final String desc;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          )),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              desc,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          )),
        ],
      ),
    );
  }
}
