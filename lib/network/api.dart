import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Network {
  String url = 'https://dev.thedatabase.net/api/ovulu/';

//SIgnUp Method
  Future<dynamic> signUpUser(
      {required String email, required String password}) async {
    var url = Uri.parse(this.url + 'signup');
    http.Response response =
        await http.post(url, body: {"Email": email, "Password": password});
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else if (response.statusCode == 300) {
      return false;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  //Signin Method
  Future<dynamic> signInUser(
      {required String email, required String password}) async {
    String username = email;
    String pass = password;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$pass'));
    print(basicAuth);
    var url = Uri.parse(this.url + 'signin');
    http.Response response = await http
        .get(url, headers: <String, String>{'authorization': basicAuth});
    if (response.statusCode == 200) {
      String data = response.body;
      SharedPreferences prefs = await SharedPreferences.getInstance();
       prefs.setString('basicAuth', basicAuth);

      print(data);
      return jsonDecode(data);
    } else if (response.statusCode == 401) {
      print('IN 401');
      return false;
    } else {
      print(response.body);
      print('IN NULL');
      return null;
    }
  }

  //Signin Method
  Future<dynamic> updateData(
      {required String email,
      required String password,
      required Map<String, String> body}) async {
    print(json.encode(body));
    String username = email;
    String pass = password;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$pass'));
    print(basicAuth);

    var url = Uri.parse(this.url + 'customer/update');
    // final body = {"EMAIL": "AFAQ", "PASS": "123"};
    http.Response response = await http.post(url,
        headers: <String, String>{
          'authorization': basicAuth,
          "Content-Type": "application/json"
        },
        body: json.encode(body));
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      print(response.body);
      return null;
    }
  }

  Future<dynamic> passwordReminder({required String email}) async {
    String baseUrl = 'https://dev.thedatabase.net/api/';
    var url = Uri.parse(baseUrl + 'passwordreminder?email=$email');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<dynamic> checkOtp({required String email, required String otp}) async {
    print('EMAIL>>$email, OTP>>$otp');
    var url = Uri.parse('${this.url}changepassword');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(url,
        body: json.encode({"Email": email, "Code": otp}), headers: headers);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else if (response.statusCode == 406) {
      return false;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<dynamic> changePassword(
      {required String email,
      required String otp,
      required String newPassword}) async {
    print('EMAIL>>$email, OTP>>$otp');
    var url = Uri.parse('${this.url}changepassword');
    http.Response response = await http.post(url,
        body: json
            .encode({"Email": email, "Code": otp, "NewPassword": newPassword}),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
