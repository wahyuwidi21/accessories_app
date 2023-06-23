import 'package:accessories_app/bloc/profile/profile_bloc.dart';
import 'package:accessories_app/data/repository/auth_repository.dart';
import 'package:accessories_app/ui/profile/components/photo.dart';
import 'package:accessories_app/utils/colors.dart';
import 'package:accessories_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HeaderProfile extends StatelessWidget {
  HeaderProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig.screenHeight / 4,
      child: Stack(alignment: Alignment.center, children: [
        Container(
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          decoration: const BoxDecoration(
              backgroundBlendMode: BlendMode.multiply,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [kPrimaryColor, kPrimaryDarkColor])),
          width: double.infinity,
          height: double.infinity,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PhotoProfile(),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: BlocProvider(
                        create: ((context) =>
                            ProfileBloc(context.read<AuthRepository>())
                              ..add(FetchProfile())),
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                            builder: ((context, state) {
                          if (state is ProfileSuccess) {
                            return Text(
                              "${state.response.fullname}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                            );
                          } else if (state is ProfileLoading) {
                            return const CircularProgressIndicator();
                          } else if (state is ProfileFailed) {
                            return Text(state.message);
                          } else {
                            return SizedBox();
                          }
                        }))),
                  ),
                ]))
      ]),
    );
  }
}
