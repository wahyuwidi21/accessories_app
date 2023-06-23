import 'package:accessories_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PhotoProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kPrimaryDarkColor,
          border: Border.all(color: Colors.white, width: 3)),
      child: SvgPicture.asset("assets/icons/ic_default_photo.svg"),
    );
  }
}
