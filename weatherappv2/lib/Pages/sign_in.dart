import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weatherappv2/Routes/routes.dart';
import 'package:weatherappv2/Tools/string_extension.dart';
import 'package:weatherappv2/Widgets/sign_in_form.dart';

class SignIn extends StatefulWidget {

  const SignIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();

}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String mail = '';
  String password = '';
  String username = '';
  bool isToRemember = false;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, Routes.weatherList);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(fontSize: 24, color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildBody(),
            const SizedBox(height: 8),
            buildButton(),
            const SizedBox(height: 16),
            buildSignUp()
          ],
        ),
      ),
    );
  }

  void processLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: mail, password: password);
    } on FirebaseAuthException catch (e) {
      //
    }
  }

  Widget buildBody() {
    return Form(
      key: _formKey,
      child: SignInForm(
        mail: '',
        password: '',
        onChangeMail: (mail) =>  setState(() {
          this.mail = mail;
        }),
        onChangePassword: (password) => setState(() {
          this.password = password;
        }),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = mail.isNotEmpty && password.isNotEmpty && mail.isMailValid();

    return TextButton(
      onPressed: isFormValid ? processLogin : null,
      style: TextButton.styleFrom(
          padding: const EdgeInsets.only(left: 32,top: 16, right: 32,bottom: 16),
          textStyle: const TextStyle(fontSize: 20, color: Colors.white),
          backgroundColor: isFormValid ? Colors.blue : Colors.grey.shade700
      ),
      child: const Text('Connexion', style: TextStyle(fontSize: 20, color: Colors.white),),
    );
  }

  Widget buildSignUp() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.signUp);
      },
      child: const Text('Crée un compte', style: TextStyle(fontSize: 16, decoration: TextDecoration.underline)),
    );
  }


}