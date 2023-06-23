import 'package:accessories_app/ui/login/login_screen.dart';
import 'package:accessories_app/ui/onboarding/components/onboarding_widget.dart';
import 'package:accessories_app/utils/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final PageController controller = PageController();
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                  backgroundBlendMode: BlendMode.multiply,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [kPrimaryColor, kPrimaryColor])),
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: SvgPicture.asset(
                        "assets/icons/ic_app.svg",
                      ),
                    ),
                  ],
                )),
              ],
            )
          ],
        )),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: PageView(
                    controller: controller,
                    onPageChanged: (page) {
                      setState(() {
                        currentPage = page;
                      });
                    },
                    children: const [
                  OnboardingWidget(
                    title: "Akses dimanapun",
                    desc:
                        "Akses dimanapun dan kapan pun anda inginkan tanpa repot-repot ke toko penjualan",
                  ),
                  OnboardingWidget(
                    title: "Berbagai Macam fitur unggulan",
                    desc:
                        "Aplikasi ini menyediakan berbagai macam fitur yang menunjang kamu agar lebih mudah ketika anda menggunakannya",
                  ),
                  OnboardingWidget(
                    title: "Selalu ada yang menarik",
                    desc:
                        "Akan selalu ada berbagai jenis produk menarik yang menantikan anda ",
                  ),
                ])),
            Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DotsIndicator(
                      dotsCount: 3,
                      position: currentPage,
                      decorator: const DotsDecorator(
                          color: Color(0xffd9d9d9),
                          activeColor: kPrimaryColor,
                          size: Size(15.0, 15.0),
                          activeSize: Size(15.0, 15.0)),
                    ),
                    Visibility(
                        visible: currentPage == 2,
                        child: InkWell(
                          child: const Text(
                            "Lanjut",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.popAndPushNamed(
                                context, LoginScreen.routeName);
                          },
                        ))
                  ],
                ))
          ],
        ))
      ],
    );
  }
}
