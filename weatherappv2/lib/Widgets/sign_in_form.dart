import 'package:flutter/material.dart';

class SignInForm extends StatelessWidget {
  final String? mail;
  final String? password;

  final ValueChanged<String> onChangeMail;
  final ValueChanged<String> onChangePassword;

  const SignInForm({
    Key? key,
    this.mail = 'Mail',
    this.password = 'Password',
    required this.onChangeMail,
    required this.onChangePassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(32),
    child: Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: const Text('Mail', style: TextStyle(fontSize: 18, color: Colors.grey),),
        ),
        const SizedBox(height: 8,),
        buildMail(),
        const SizedBox(height: 8,),
        Container(
          alignment: Alignment.topLeft,
          child: const Text('Password', style: TextStyle(fontSize: 18, color: Colors.grey),),
        ),
        const SizedBox(height: 8,),
        buildPassword(),
      ],
    ),
  );

  Widget buildMail() => TextFormField(
    key: const Key('signInMailFormKey'),
    maxLines: 1,
    initialValue: mail,
    style: const TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
    ),
    validator: (mail) =>
    mail != null && mail.isEmpty ? 'The mail cannot be empty' : null,
    onChanged: onChangeMail,
  );

  Widget buildPassword() => TextFormField(
    key: const Key('signInPasswordFormKey'),
    obscureText: true,
    maxLines: 1,
    initialValue: password,
    style: const TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
    ),
    validator: (password) =>
    password != null && password.isEmpty ? 'The password cannot be empty' : null,
    onChanged: onChangePassword,
  );



}