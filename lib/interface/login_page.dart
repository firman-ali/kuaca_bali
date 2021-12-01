import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/common/constant.dart';
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
                    child: SvgPicture.asset(loginImageAsset,
                        width: size.width * 0.7),
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
                        const SizedBox(height: 15),
                        CustomPasswordField(
                          controller: passTextController,
                          prefixIcon: Icons.lock,
                          labelText: passLabel,
                          suffix: true,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Lupa Password ?',
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      emailTextController.text +
                                          passTextController.text,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeInUp(
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(text: 'Belum Punya Akun? '),
                            TextSpan(
                              text: 'Daftar Disini!',
                              style: const TextStyle(color: secondary700),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
