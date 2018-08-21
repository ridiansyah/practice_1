import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class GoAuth {
  Future<bool> onLogin(String email, String password);
  Future<bool> onSignUp(String name, String phone_number, String email, String password, String birth_date);
  Future<bool> onSignOut();
  Future<bool> onForgotPassword(String email);
  Future<bool> onLoggedIn();
}

class Auth implements GoAuth {

  String _token;
  String key = 'token';
  String url;
  FlutterSecureStorage storage = new FlutterSecureStorage();
  bool _res = false;

  Future<bool> onLogin(String email, String password) async {
    try{
      url = 'http://localhost:3000/authentication/proccess';
      await http.post(url, body : {'email' : email, 'password' : password}).then((response){
        String body = response.body;
        var data = json.decode(body);
        if(data['status']){
          storage.write(key : key,value: data['token']);
          _res = true;
        }else{
          _res = false;
        }
      });
    } catch (err) {
      _res = false;
    }
    return _res;
  }

  Future<bool> onSignUp(String name, String phone_number, String email, String password, String birth_date) async {
    try{
      url = 'http://localhost:3000/authentication/proccess';
      await http.post(url, body : {'email' : email, 'phone_number' : phone_number, 'password' : password, 'birth_date' : birth_date}).then((response){
        String body = response.body;
        var data = json.decode(body);
        if(data['status']){
          storage.write(key : key,value: data['token']);
          _res = true;
        }else{
          _res = false;
        }
      });
    } catch (err) {
      _res = false;
    }
    return _res;
  }
  
  Future<bool> onSignOut() async {
    try{
      await storage.delete(key : key).then((status){
        _res = true;
      });
    } catch (err) {
      _res = false;
    }
    return _res;
  }

  Future<bool> onForgotPassword(String email){

  }

  Future<bool> onLoggedIn() async {
    try{
      await storage.read(key : key).then((value){
        if(value != null){
          _res = true;
        }else{
          _res = false;
        }
      });
    } catch (err) {
      _res = false;
    }
    return _res;
  }

}
