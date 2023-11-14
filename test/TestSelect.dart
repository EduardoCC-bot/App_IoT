import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;


// ignore: camel_case_types
class getUserInfo {
  var url = Uri.parse('https://apihomeiot.online/v1.0/db?db=SQL&crud=SELECT&data=SELECT%20*%20FROM%20Persona%20WHERE%20UID=');


  Future<http.Response> getInfo() async{
    var si = null;
    try {
      final response = await http.get(url);
      return response;
    } catch (e) {
      print(e);
      return si;  
    }
  }
  
}