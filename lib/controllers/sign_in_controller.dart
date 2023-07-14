import 'package:get/get.dart';
import 'package:ovulu/models/user_model.dart';
import 'package:ovulu/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  String email = '';
  String otp = '';
  String recordId = '';
  String password = '';
  String name = '';
  String pregnantOrNot = '';
  String listOfDiagnoses = '';
  DateTime? date;
  String averagePeriodCycle = '';
  String height = '', weight = '', age = '', activity = '';
  dynamic userData;

  signInUser() async {
    print('${email} ${password}');
    userData = await Network().signInUser(email: email, password: password);
    if (userData != null) {
      if (userData != false) {
        MyUser user = MyUser.fromJson(userData);
        print('DATA IN IF>>>${user.recordID}');
        email = user.email!;
        recordId = user.recordID!;
        print('RECORD ID>>>>${recordId}');
        name = user.name!;
        pregnantOrNot = user.currentlyPregnant!;
        listOfDiagnoses = user.comorbidities!;
        // date = DateTime(int.parse(user.periodFirstDay!));
        averagePeriodCycle = user.daysinCycle!;
        height = user.height!;
        weight = user.weight!;
        age = user.age!;
        activity = user.activity!;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('userLoggedIn', true);
        prefs.setString('userRecordId', recordId);
        print(prefs.getString('userRecordId'));
        return true;
      } else {
        print('DATA IN ELSE>>>>$userData');
        return false;
      }
    } else {
      return null;
    }
  }

  Future<dynamic> passwordReminder({required String email}) async {
    final data = await Network().passwordReminder(email: email);
    print(data);
    if (data != null) {
      if (data.toString().contains('Email not found.')) {
        return false;
      } else {
        print(data);
        recordId = data;
        return true;
      }
    } else {
      return null;
    }
  }

  checkOtp({required String email, required String otp}) async {
    final data = await Network().checkOtp(email: email, otp: otp);
    print('Response in controller-->$data');
    if (data != null) {
      if (data != false) {
        return true;
      } else {
        print(data);
        return false;
      }
    } else {
      return null;
    }
  }

  changePassword(
      {required String email,
      required String otp,
      required String newPassword}) async {
    final data = await Network()
        .changePassword(email: email, otp: otp, newPassword: newPassword);
    print(data);
    if (data != null) {
      if (data.toString().contains('Code is not correct.')) {
        return false;
      } else {
        print(data);
        return true;
      }
    } else {
      return null;
    }
  }

  Future<dynamic> syncUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userLoggedIn = (prefs.getBool('userLoggedIn') ?? false);
    String userRecordId = (prefs.getString('userRecordId') ?? '');
    if (userRecordId != '' && userLoggedIn) {
      return true;
    } else {
      return false;
    }
  }
}
