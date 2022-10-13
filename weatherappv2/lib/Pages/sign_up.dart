import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weatherappv2/Routes/routes.dart';
import 'package:weatherappv2/Tools/string_extension.dart';
import 'package:weatherappv2/Widgets/sign_up_form.dart';

class SignUp extends StatefulWidget {

  const SignUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpState();

}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  String mail = '';
  String password = '';
  String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription', style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildBody(),
            const SizedBox(height: 8),
            buildButton(),
          ],
        ),),
    );
  }

  Widget buildBody() {
    return Form(
      key: _formKey,
      child: SignUpForm(
        mail: '',
        password: '',
        username: '',
        onChangeUsername: (username) => setState(() => this.username = username),
        onChangeMail: (mail) => setState(() => this.mail = mail),
        onChangePassword: (password) => setState(() => this.password = password),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = mail.isNotEmpty && password.isNotEmpty && username.isNotEmpty && mail.isMailValid();

    return TextButton(
      key: const Key('signUpButtonFormKey'),
      onPressed: isFormValid ? processSignUp : null,
      style: TextButton.styleFrom(
          padding: const EdgeInsets.only(left: 32,top: 16, right: 32,bottom: 16),
          textStyle: const TextStyle(fontSize: 20, color: Colors.white),
          backgroundColor: isFormValid ? Colors.blue : Colors.grey.shade700
      ),
      child: const Text('S\'inscrire', style: TextStyle(fontSize: 20, color: Colors.white),),
    );
  }

  void processSignUp() async {
    final isValid = _formKey.currentState!.validate();
    FirebaseAuth instance = FirebaseAuth.instance;
    if (isValid) {
      instance.createUserWithEmailAndPassword(email: mail, password: password).whenComplete(() => {
        if (instance.currentUser != null) {
          instance.currentUser!.updateDisplayName(username)
        }
      });
      }
    }


  void processToWeatherList() {
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(Routes.weatherList);
  }

}