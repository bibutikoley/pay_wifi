import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_wifi/custom_views/auth_page_check_box.dart';
import 'package:pay_wifi/custom_views/custom_outlined_button.dart';
import 'package:pay_wifi/custom_views/custom_primary_button.dart';
import 'package:pay_wifi/screens/auth/register_screen.dart';
import 'package:pay_wifi/screens/on_boarding/landing_screen.dart';
import 'package:pay_wifi/state_managers/auth_page_state_manager.dart';
import 'package:pay_wifi/store/app_store.dart';
import 'package:pay_wifi/theme.dart';
import 'package:pay_wifi/utils.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final AuthPageStateManager _authPageStateManager = Get.find();
  final AppStore _appStore = Get.find();

  void togglePassword() {
    _authPageStateManager.isPasswordVisible.value =
        _authPageStateManager.isPasswordVisible.toggle().value;
  }

  void toggleRememberMeAction() {
    _authPageStateManager.isRememberMeChecked.value =
        _authPageStateManager.isRememberMeChecked.toggle().value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login to your\naccount',
                        style: heading2.copyWith(color: textBlack),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/images/accent.png',
                        width: 99,
                        height: 4,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Form(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: Obx(
                            () => TextFormField(
                              obscureText: _authPageStateManager
                                  .isPasswordVisible.isFalse,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: heading6.copyWith(color: textGrey),
                                suffixIcon: IconButton(
                                  color: textGrey,
                                  splashRadius: 1,
                                  icon: Icon(_authPageStateManager
                                          .isPasswordVisible.isFalse
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                  onPressed: togglePassword,
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AuthPageCheckBox(),
                      const SizedBox(
                        width: 12,
                      ),
                      GestureDetector(
                          onTap: toggleRememberMeAction,
                          child: Text('Remember me', style: regular16pt)),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomPrimaryButton(
                    buttonColor: primaryBlue,
                    textValue: 'Login',
                    textColor: Colors.white,
                    onPressed: () {
                      _appStore.login(generateRandomString(64));
                      Future.delayed(const Duration(seconds: 4), () {
                        Get.off(() => LandingScreen());
                      });
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: Text(
                      'OR',
                      style: heading6.copyWith(color: textGrey),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomOutlinedButton(
                    buttonStrokeColor: primaryBlue,
                    textValue: 'Login with Google',
                    textColor: textBlack,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: regular16pt.copyWith(color: textGrey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            SizedBox(
                              height: (Get.height * 0.85),
                              child: RegisterPage(),
                            ),
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                            ),
                            enterBottomSheetDuration:
                                const Duration(milliseconds: 400),
                            exitBottomSheetDuration:
                                const Duration(milliseconds: 400),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                          );
                        },
                        child: Text(
                          'Register',
                          style: regular16pt.copyWith(color: primaryBlue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
