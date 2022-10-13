import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  final String? username;
  final String? mail;
  final String? password;

  final ValueChanged<String> onChangeUsername;
  final ValueChanged<String> onChangeMail;
  final ValueChanged<String> onChangePassword;

  const SignUpForm({
    Key? key,
    this.username = '',
    this.mail = '',
    this.password = '',
    required this.onChangeUsername,
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
          child: const Text('Username', style: TextStyle(fontSize: 18, color: Colors.grey),),
        ),
        const SizedBox(height: 8,),
        buildUsername(),
        const SizedBox(height: 8,),
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

  Widget buildUsername() => TextFormField(
    key: const Key('signUpUsernameFormKey'),
    maxLines: 1,
    initialValue: username,
    style: const TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
    ),
    validator: (mail) =>
    mail != null && mail.isEmpty ? 'The username cannot be empty' : null,
    onChanged: onChangeUsername,
  );

  Widget buildMail() => TextFormField(
    key: const Key('signUpMailFormKey'),
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
    key: const Key('signUpPasswordFormKey'),
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
    validator: (mail) =>
    mail != null && mail.isEmpty ? 'The password cannot be empty' : null,
    onChanged: onChangePassword,
  );

}