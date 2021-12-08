import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/common/constant.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/helper/page_navigation_helper.dart';
import 'package:kuaca_bali/interface/home_page.dart';
import 'package:kuaca_bali/interface/login_page.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:kuaca_bali/widget/custom_form_field.dart';
import 'package:kuaca_bali/widget/custom_password_field.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const routeName = '/register';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passTextController = TextEditingController();
  TextEditingController confirmPassTextController = TextEditingController();
  TextEditingController telpTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameTextController.dispose();
    emailTextController.dispose();
    passTextController.dispose();
    confirmPassTextController.dispose();
    telpTextController.dispose();
    addressTextController.dispose();
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SafeArea(
                    child: FadeInDown(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Buat Akun Baru',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            'Buat akun kuacamu untuk melihat kumpulan busana adat yang keren',
                            style: Theme.of(context).textTheme.subtitle1,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeIn(
                    duration: const Duration(seconds: 1),
                    child: Column(
                      children: [
                        CustomFormField(
                          controller: nameTextController,
                          labelText: nameLabel,
                          prefixIcon: Icons.person,
                          textInputAction: TextInputAction.next,
                        ),
                        CustomFormField(
                          marginTop: 15.0,
                          controller: emailTextController,
                          labelText: emailLabel,
                          prefixIcon: Icons.email,
                          textInputAction: TextInputAction.next,
                        ),
                        CustomPasswordField(
                          marginTop: 15.0,
                          controller: passTextController,
                          labelText: passLabel,
                          prefixIcon: Icons.vpn_key,
                          textInputAction: TextInputAction.next,
                        ),
                        CustomPasswordField(
                          marginTop: 15.0,
                          controller: confirmPassTextController,
                          labelText: confirmPassLabel,
                          prefixIcon: Icons.vpn_key,
                          textInputAction: TextInputAction.next,
                        ),
                        CustomFormField(
                          marginTop: 15.0,
                          controller: telpTextController,
                          labelText: telpLabel,
                          prefixIcon: Icons.phone,
                          textInputAction: TextInputAction.next,
                        ),
                        CustomFormField(
                          marginTop: 15.0,
                          controller: addressTextController,
                          labelText: addressLabel,
                          prefixIcon: Icons.add_location,
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final result =
                                      await Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .signUp(
                                    emailTextController.text,
                                    passTextController.text,
                                    nameTextController.text,
                                    telpTextController.text,
                                    addressTextController.text,
                                  );
                                  if (result == "success") {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PageNavigation()));
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                }
                              }
                            },
                            child: const Text(registerButton),
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
                            const TextSpan(text: haveAccount),
                            TextSpan(
                              text: loginLabel,
                              style: const TextStyle(color: secondary700),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                      context, LoginPage.routeName);
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
