import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/common/constant.dart';
import 'package:kuaca_bali/helper/page_navigation_helper.dart';
import 'package:kuaca_bali/interface/lupa_pass.dart';
import 'package:kuaca_bali/interface/register_page.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:kuaca_bali/widget/custom_form_field.dart';
import 'package:kuaca_bali/widget/custom_password_field.dart';
import 'package:provider/provider.dart';

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
                  SvgPicture.asset(loginImageAsset),
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
                          onPressed: () {
                            Navigator.pushNamed(
                                context, LupapassPage.routeName);
                          },
                          child: Text(
                            forgetPassLabel,
                            style: GoogleFonts.publicSans(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: onSurface,
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
                                  final result = Provider.of<AuthProvider>(
                                      context,
                                      listen: false);
                                  await result.signIn(
                                    emailTextController.text,
                                    passTextController.text,
                                  );
                                  if (result.isSignIn) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PageRouter()),
                                    );
                                  }
                                } on FirebaseAuthException catch (e) {
                                  late String message;
                                  if (e.code == 'user-not-found') {
                                    message = 'No user found for that email.';
                                  } else if (e.code == 'wrong-password') {
                                    message =
                                        'Wrong password provided for that user.';
                                  } else {
                                    message = e.toString();
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
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
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(color: secondary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                      context, RegisterPage.routeName);
                                },
                            ),
                          ],
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(color: onSurface),
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
