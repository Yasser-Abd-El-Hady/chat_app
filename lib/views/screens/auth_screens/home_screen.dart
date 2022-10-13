import 'package:chat_app/utils/color.dart';
import 'package:chat_app/utils/screen.dart';
import 'package:chat_app/views/components/custom_text.dart';
import 'package:chat_app/views/components/snackbar.dart';
import 'package:chat_app/views/components/text_form_field.dart';
import 'package:chat_app/views/screens/auth_screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static String pageRoute = 'AuthPage';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String authMode = "Signup";
  bool _isLoading = false;

  String email = "";
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Screen(context);
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        body: Container(
          color: AppColors.primary,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: Screen.screenHeight / (926 / 100)),
                Image.asset("assets/images/chat.png", width: 150, height: 150),
                SizedBox(height: Screen.screenHeight / (926 / 25)),
                const CustomText(
                    text: "Text Me !",
                    fontFamily: "Pacifico",
                    color: Colors.white,
                    fontSize: 40),
                SizedBox(height: Screen.screenHeight / (926 / 50)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Screen.screenWidth / (428 / 10)),
                  child: Form(
                    key: key,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextFormField(
                            controller: _emailController,
                            labelName: "Email",
                            keyboardType: TextInputType.emailAddress,
                            validator: (input) {
                              if (input!.isEmpty || !input.contains('@')) {
                                return "Email Field is Required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: Screen.screenHeight / (926 / 20)),
                          CustomTextFormField(
                            obscureText: true,
                            obscuringCharacter: '*',
                            controller: _passwordController,
                            labelName: "Password",
                            validator: (input) {
                              if (input!.isEmpty || input.length < 5) {
                                return "Password length must be greater than 5 characters";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: Screen.screenHeight / (926 / 35)),
                          SizedBox(
                            height: 45,
                            child: ElevatedButton(
                              child: CustomText(
                                  text: authMode == "Signup"
                                      ? "Register"
                                      : "Login",
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)))),
                              onPressed: () async {
                                if (key.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  if (authMode == "Signup") {
                                    await signup(context).then((value) {
                                      Navigator.popAndPushNamed(
                                          context, ChatScreen.pageRoute,
                                          arguments: email);
                                    }, onError: (e) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      customSnackBar(
                                          context, Text(e.toString()));
                                    });
                                  } else {
                                    await login(context).then(
                                        (value) => Navigator.popAndPushNamed(
                                            context, ChatScreen.pageRoute,
                                            arguments: email), onError: (e) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      customSnackBar(
                                          context, Text(e.toString()));
                                    });
                                  }
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: authMode == "Signup"
                                    ? "Already have an account ?"
                                    : "Don't have an account ?",
                                color: Colors.white,
                              ),
                              TextButton(
                                  onPressed: () {
                                    authMode == "Signup"
                                        ? authMode = "Login"
                                        : authMode = "Signup";
                                    _emailController.clear();
                                    _passwordController.clear();
                                    setState(() {});
                                  },
                                  child: Text(
                                    authMode == "Signup" ? "Login" : "SignUp",
                                    style: const TextStyle(
                                        color: Colors.deepOrange),
                                  ))
                            ],
                          )
                        ]),
                  ),
                ),
                // SizedBox(height: Screen.screenHeight / (926 / 175)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      email = credential.user!.email!;
    } on FirebaseAuthException catch (e) {
      throw e.code;
      // if (e.code == 'user-not-found') {
      //   throw ('No user found for that email.');
      //   // customSnackBar(context, const Text('No user found for that email.'));
      // } else if (e.code == 'wrong-password') {
      //   throw ('Wrong password provided for that user.');
      //   // customSnackBar(
      //   //     context, const Text('Wrong password provided for that user.'));
      // }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signup(BuildContext context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      email = credential.user!.email!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
