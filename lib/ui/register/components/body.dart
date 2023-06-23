import 'package:accessories_app/bloc/register/register_bloc.dart';
import 'package:accessories_app/data/model/profile_model.dart';
import 'package:accessories_app/data/repository/auth_repository.dart';
import 'package:accessories_app/ui/login/login_screen.dart';
import 'package:accessories_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late RegisterBloc registerBloc;
  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> namaKey;
  late GlobalKey<FormState> emailKey;
  late GlobalKey<FormState> passwordKey;

  @override
  void initState() {
    registerBloc = RegisterBloc(context.read<AuthRepository>());
    namaController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    namaKey = GlobalKey<FormState>();
    emailKey = GlobalKey<FormState>();
    passwordKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: ((context) => registerBloc)),
        ],
        child: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                Navigator.popAndPushNamed(context, LoginScreen.routeName);
              } else if (state is RegisterFailed) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 50, right: 10, left: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Buat Akun",
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
                          "Nama",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: Colors.black),
                        )),
                    Form(
                        key: namaKey,
                        child: TextFormField(
                          controller: namaController,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please fill this field';
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
                                registerBloc.add(RegisterUser(
                                    profileModel: ProfileModel(
                                        fullname: namaController.text,
                                        email: emailController.text,
                                        password: passwordController.text)));
                              }
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              child: const Text("Buat Akun",
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
                            const Text("Sudah punya akun? ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            InkWell(
                              onTap: () {
                                Navigator.popAndPushNamed(
                                    context, LoginScreen.routeName);
                              },
                              child: const Text("Masuk",
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
