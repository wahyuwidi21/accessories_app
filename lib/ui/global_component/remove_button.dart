import 'package:accessories_app/utils/colors.dart';
import 'package:flutter/material.dart';

class RemoveButton extends StatelessWidget {
  RemoveButton(this.onClick);

  Function()? onClick;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.only(bottom: 5, right: 5),
        decoration: BoxDecoration(
            color: kPrimaryColor, borderRadius: BorderRadius.circular(4)),
        child: const Icon(
          Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}
