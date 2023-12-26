import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'info.dart';
import 'api.dart';
import 'widgets/gradient.dart';
import 'widgets/loginlabel.dart';
import 'widgets/loginfield.dart';
import 'widgets/privacy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(title: 'HomePage'),
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.title});
  final String title;

  final TextEditingController userController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: GradientBackground(
      child: Center(
        child: Column(
          children: [
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const LoginLabel(text: 'Usuário'),
                  LoginField(
                    textController: userController,
                    obscureText: false,
                    inputFormatter:
                        FilteringTextInputFormatter.allow(RegExp(r'.')),
                    icon: Icons.person,
                  ),
                  const LoginLabel(text: 'Senha'),
                  LoginField(
                    textController: passwordController,
                    obscureText: true,
                    inputFormatter: FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9]')),
                    icon: Icons.lock,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String userText = userController.text;
                      String passwordText = passwordController.text;
                      var apiResponse = callApi(userText, passwordText);
                      if (apiResponse['sucess'] == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    InfoScreen(title: 'HomePage')));
                      } else if (apiResponse['error'] ==
                          'Campo de usuario vazio') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: (Text('Preencha o campo de usuário.')),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red));
                      } else if (apiResponse['error'] ==
                          'Campo de senha vazio') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: (Text('Preencha o campo de senha.')),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red));
                      } else if (apiResponse['error'] ==
                          'Campo termina com espaco') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: (Text(
                                'Nenhum dos campos podem terminar com caractere de espaço.')),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.red));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: (Text(
                                    'A senha deve ter mais que 2 caracteres')),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red));
                      }
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 69, 189, 111))),
                    child: SizedBox(
                        width: 150,
                        height: 50,
                        child: Center(
                            child: Text(
                          'Entrar',
                          style: TextStyle(
                              color: Colors.white, fontSize: screenWidth / 22),
                        ))),
                  ),
                ])),
          PrivacyPolicy()
          ],
        ),
      ),
    ));
  }
}
