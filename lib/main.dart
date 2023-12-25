import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'info.dart';
import 'api.dart';

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
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 31, 79, 98),
                Color.fromARGB(255, 37, 112, 118),
                Color.fromARGB(255, 47, 150, 142)
              ],
              begin: Alignment.topCenter,
              stops: [0.1, 0.7, 1])),
      child: Center(
        child: Column(
          children: [
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: screenWidth / 12, bottom: screenHeight / 200),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Usuário',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: const Color.fromARGB(255, 219, 219, 219),
                                  fontSize: screenWidth / 25))),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: screenWidth / 15,
                          right: screenWidth / 15,
                          bottom: screenHeight / 33),
                      child: TextFormField(
                          controller: userController,
                          maxLength: 20,
                          decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              prefixIcon: const Icon(Icons.person)))),
                  Container(
                    margin: EdgeInsets.only(
                        left: screenWidth / 12, bottom: screenHeight / 200),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Senha',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: const Color.fromARGB(255, 219, 219, 219),
                                  fontSize: screenWidth / 25))),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: screenWidth / 15,
                          right: screenWidth / 15,
                          bottom: screenHeight / 33),
                      child: TextFormField(
                          controller: passwordController,
                          maxLength: 20,
                          obscureText: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z0-9]')),
                          ],
                          decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              prefixIcon: const Icon(Icons.lock)))),
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
            InkWell(
                onTap: () async {
                  Uri url = Uri.parse('https://www.google.com.br/');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: screenHeight / 100),
                    child: Text('Política de privacidade',
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 219, 219, 219)),
                            fontSize: screenWidth / 30)))),
          ],
        ),
      ),
    ));
  }
}
