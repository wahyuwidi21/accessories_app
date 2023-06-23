import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileMenuItem extends StatelessWidget {
  ProfileMenuItem(
      {Key? key,
      required this.onMenuClicked,
      this.menuIconUri,
      this.icon,
      required this.menuName})
      : super(key: key);

  Function onMenuClicked;
  String? menuIconUri;
  Icon? icon;
  String menuName;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 12),
        child: InkWell(
          onTap: () {
            onMenuClicked();
          },
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: menuIconUri != null
                        ? menuIconUri?.substring(menuIconUri!.length - 3) ==
                                "svg"
                            ? Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: SvgPicture.asset(
                                  menuIconUri!,
                                  width: 13,
                                  height: 13,
                                ))
                            : Image.asset(
                                menuIconUri!,
                                width: 16,
                                height: 16,
                              )
                        : icon,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 16.5),
                      child: Text(menuName)),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(right: 9),
                    child: SvgPicture.asset("assets/icons/ic_chevron.svg"),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1,
                margin: const EdgeInsets.only(top: 10),
                color: const Color(0xfff2f2f2),
              )
            ],
          ),
        ));
  }
}
