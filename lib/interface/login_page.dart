import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/common/constant.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/interface/home_page.dart';
import 'package:kuaca_bali/interface/register_page.dart';
import 'package:kuaca_bali/widget/custom_form_field.dart';
import 'package:kuaca_bali/widget/custom_password_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: primary100,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Center(
                    child: SvgPicture.asset(
                      loginImageAsset,
                      width: size.width * 0.8,
                    ),
                  ),
                  const SizedBox(height: 15),
                  FadeInUp(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomFormField(
                          controller: emailTextController,
                          prefixIcon: Icons.email,
                          labelText: emailLabel,
                          textInputAction: TextInputAction.next,
                        ),
                        CustomPasswordField(
                          marginTop: 15.0,
                          controller: passTextController,
                          prefixIcon: Icons.lock,
                          labelText: passLabel,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            forgetPassLabel,
                            style: GoogleFonts.publicSans(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final result = await AuthService().signIn(
                                    emailTextController.text,
                                    passTextController.text,
                                  );
                                  if (result != null) {
                                    Navigator.pushReplacementNamed(
                                        context, HomePage.routeName);
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                }
                              }
                            },
                            child: const Text(loginButton),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeInUp(
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 30.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(text: dontHaveAccount),
                            TextSpan(
                              text: registerLabel,
                              style: const TextStyle(color: secondary700),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                      context, RegisterPage.routeName);
                                },
                            ),
                          ],
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
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
