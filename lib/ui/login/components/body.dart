import 'dart:async';
import 'dart:io' show Platform;
import 'package:accessories_app/bloc/login/login_bloc.dart';
import 'package:accessories_app/data/repository/auth_repository.dart';
import 'package:accessories_app/main_screen.dart';
import 'package:accessories_app/ui/register/register_screen.dart';
import 'package:accessories_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late LoginBloc loginBloc;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> emailKey;
  late GlobalKey<FormState> passwordKey;

  @override
  void initState() {
    loginBloc = LoginBloc(context.read<AuthRepository>());
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailKey = GlobalKey<FormState>();
    passwordKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: ((context) => loginBloc)),
        ],
        child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.popAndPushNamed(context, MainScreen.routeName);
              } else if (state is LoginFailed) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 50),
                        child: SvgPicture.asset(
                          "assets/icons/ic_app_green.svg",
                          width: 100,
                          height: 100,
                        )),
                    Container(
                      width: double.infinity,
                      height: 1,
                      margin: const EdgeInsets.only(
                          top: 20, left: 26, right: 26, bottom: 25),
                      color: const Color(0xffC0B5B5),
                    ),
                    const Text(
                      "Silahkan Masukkan",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 36),
                        child: const Text(
                          "Email",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: Colors.black),
                        )),
                    Form(
                        key: emailKey,
                        child: TextFormField(
                          controller: emailController,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please fill this field';
                            }
                            if (!text.contains('@') || !text.contains('.')) {
                              return 'Wrong format';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            emailKey.currentState?.validate();
                          },
                          autofocus: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            // errorBorder: InputBorder.none,
                            hintText: "Masukkan email anda",
                            hintStyle: TextStyle(
                              fontSize: 13,
                            ),
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 10, bottom: 16, top: 16, right: 10),
                          ),
                        )),
                    Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 36),
                        child: const Text(
                          "Password",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: Colors.black),
                        )),
                    Form(
                        key: passwordKey,
                        child: TextFormField(
                          controller: passwordController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please fill this field';
                            }

                            return null;
                          },
                          onChanged: (val) {
                            passwordKey.currentState?.validate();
                          },
                          obscureText: true,
                          obscuringCharacter: '*',
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                          autofocus: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            // errorBorder: InputBorder.none,
                            hintText: "Masukkan password anda",
                            hintStyle: TextStyle(
                              fontSize: 13,
                            ),

                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 10, bottom: 16, top: 16, right: 10),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 17),
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                side: const BorderSide(
                                    width: 1, color: kPrimaryColor),
                              ),
                            ),
                            onPressed: () async {
                              if (emailKey.currentState!.validate() &&
                                  passwordKey.currentState!.validate()) {
                                loginBloc.add(AttemptLogin(
                                    email: emailController.text,
                                    password: passwordController.text));
                              }
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              child: const Text("Log In",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ))),
                    Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 46),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Belum punya akun? ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RegisterScreen.routeName);
                              },
                              child: const Text("Daftar",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            )
                          ],
                        ))
                  ],
                ))));
  }
}
