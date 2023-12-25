import 'dart:convert';

import 'package:http/http.dart' as http;

dynamic callApi(userText, passwordText) {
  late http.Response response;

  if (userText.isEmpty) {
    response = http.Response(jsonEncode({'sucess': false, 'error': 'Campo de usuario vazio'}), 400);
  } else if (passwordText.isEmpty) {
    response = http.Response(jsonEncode({'sucess': false, 'error': 'Campo de senha vazio'}), 400);
  } else {
    if (userText.endsWith(' ')) {
      response = http.Response(jsonEncode({'sucess': false, 'error': 'Campo termina com espaco'}), 400);
    } else if (passwordText.length < 3) {
      response = http.Response(jsonEncode({'sucess': false, 'error': 'Senha muito curta'}), 400);
    } else {
      response = http.Response(jsonEncode({'sucess': true}), 200);
    }
  }

  return json.decode(response.body);
}
