import 'package:favo_link/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginWidget();
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  LoginService service = LoginService();
  bool signIn = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _form1Key = GlobalKey();
  final GlobalKey<FormState> _form2Key = GlobalKey();
  final GlobalKey<FormState> _form3Key = GlobalKey();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: Image.asset('assets/login_pics/1.png'),
            ),
            _buildSignUp(locale),
          ],
        ),
      ),
    );
  }

  Column _buildSignUp(
    AppLocalizations locale,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Form(
            key: _form1Key,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) return "Cannot be empty";
                if (value.contains('@') == false) return 'Incorrect email';
              },
              onChanged: (text) => setState(() {}),
              controller: emailController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: locale.email,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Form(
            key: _form2Key,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) return "Cannot be empty";
              },
              onChanged: (text) => setState(() {}),
              controller: passwordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: locale.password,
              ),
            ),
          ),
        ),
        signIn == false
            ? Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Form(
                      key: _form3Key,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) return "Cannot be empty";
                          if (value != passwordController.text)
                            return 'Passwords are different';
                        },
                        onChanged: (text) => setState(() {}),
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: locale.confirmPassword,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox(),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.pink,
          ),
          onPressed: () {
            try {
              bool v1 = _form1Key.currentState!.validate();
              bool v2 = _form2Key.currentState!.validate();
              bool v3 = signIn == false ? _form3Key.currentState!.validate() : true;
              setState(() {

              });
              if(v1&&v2&&v3){
                signIn
                    ? service.signIn(
                  emailController.text,
                  passwordController.text,
                  context,
                )
                    : service.signUp(
                  emailController.text,
                  passwordController.text,
                  context,
                );
              }

            } catch (e) {
              print(e);
            }
          },
          child: Text(
            signIn == false ? locale.signUp : locale.signIn,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              signIn == false
                  ? locale.alreadyHaveAnAccount
                  : locale.firstTimeHere,
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    signIn == false ? signIn = true : signIn = false;
                  });
                },
                child: Text(
                  signIn == false ? locale.signIn : locale.signUp,
                  style: const TextStyle(
                    color: Colors.pink,
                  ),
                ))
          ],
        )
      ],
    );
  }
}

String? errorText(String text) {
  if (text.isEmpty) {
    return 'Can\'t be empty';
  }
  if (text.length < 6) {
    return 'Too short';
  }
  return null;
}
