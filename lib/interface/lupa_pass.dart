import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/common/constant.dart';
import 'package:kuaca_bali/helper/page_navigation_helper.dart';
import 'package:kuaca_bali/interface/login_page.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:kuaca_bali/widget/custom_form_field.dart';
import 'package:provider/provider.dart';

class LupapassPage extends StatefulWidget {
  const LupapassPage({Key? key}) : super(key: key);

  static const routeName = '/lupa_pass';
  @override
  _LupapassPageState createState() => _LupapassPageState();
}

class _LupapassPageState extends State<LupapassPage> {
  TextEditingController emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextController.dispose();
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
            child: Container(
              width: size.width,
              height: size.height,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SafeArea(
                    child: FadeInDown(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios)),
                          Text(
                            'Lupa Password',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeIn(
                    duration: const Duration(seconds: 1),
                    delay: const Duration(milliseconds: 200),
                    child: Column(
                      children: [
                        CustomFormField(
                          marginTop: 20.0,
                          controller: emailTextController,
                          labelText: emailLabel,
                          prefixIcon: Icons.email,
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                  ),
                  FadeIn(
                    duration: const Duration(seconds: 1),
                    delay: const Duration(milliseconds: 200),
                    child: SizedBox(
                      width: size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final result = Provider.of<AuthProvider>(context,
                                listen: false);
                            if (result.isSignIn) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PageRouter()));
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        },
                        child: const Text(registerButton),
                      ),
                    ),
                  ),
                  FadeInUp(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(text: haveAccount),
                          TextSpan(
                            text: loginLabel,
                            style: const TextStyle(color: secondary),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
