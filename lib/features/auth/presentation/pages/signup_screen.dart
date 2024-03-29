import 'package:flutter/material.dart';
import 'package:quip_sync/core/constants/const_styles.dart';
import 'package:quip_sync/features/auth/presentation/widgets/components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/utils/bloc_export.dart';
import '../../../../core/utils/injections.dart';
import '../../../../core/widgets/default_buttons.dart';
import '../../../../core/widgets/default_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Form(
          key: signUpFormKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.h,
                    child: Center(
                      child: Container(
                        height: 13.4.h,
                        width: 13.4.h,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Sign Up',
                      style: ConstStyles.headerTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  DefaultTextField(
                    hnt: 'Name',
                    controller: signUpNameController,
                    icon: Icons.person,
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  DefaultTextField(
                    hnt: 'Email',
                    controller: signUpEmailController,
                    icon: Icons.alternate_email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  DefaultTextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: signUpPasswordController,
                    hnt: "Password",
                    obscureText: true,
                    icon: Icons.security,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  DefaultButton(
                    onPressed: signUpFunc,
                    txt: 'Sign Up',
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: ConstStyles.mainTextStyle,
                        ),
                        GestureDetector(
                          onTap: () => sl<AuthBloc>()
                              .add(ToggleView(isSignIn: state.isSignIn)),
                          child: Text(
                            "Login",
                            style: ConstStyles.mainTextStyle.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

}
