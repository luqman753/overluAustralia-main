import 'package:get/get.dart';
import 'package:ovulu/network/api.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  var email = ''.obs;
  var recordId = ''.obs;
  var password = ''.obs;
  var name = ''.obs;
  var pregnantOrNot = ''.obs;
  var listOfDiagnoses = ''.obs;
  DateTime? date;
  var averagePeriodCycle = ''.obs;
  var height = ''.obs, weight = ''.obs, age = ''.obs, activity = ''.obs;
  void resetDetail() {
    print('Email>>${email.value}');
    print('Password>>${password.value}');
    print('name>>${name.value}');
    print('Pregnant Options>>${pregnantOrNot.value}');
    print('Diagnoses>>${listOfDiagnoses.value}');
    print(
        'Date>>${date != null ? DateFormat('MM/dd/yyyy').format(date!) : ''}');
    print('Average Cycle>>${averagePeriodCycle.value}');
    print('Height>>${height.value}');
    print('Weight>>${weight.value}');
    print('Age>>${age.value}');
    print('Activity>>${activity.value}');
    email.value = '';
    password.value = '';
    name.value = '';
    pregnantOrNot.value = '';
    listOfDiagnoses.value = '';
    date = null;
    averagePeriodCycle.value = '';
    height.value = '';
    weight.value = '';
    age.value = '';
    activity.value = '';
  }

  signUpUser() async {
    final data = await Network()
        .signUpUser(email: email.value, password: password.value);
    if (data != null) {
      if (data != false) {
        recordId.value = data;
        return true;
      } else {
        print(data);
        // recordId.value = data;
        return false;
      }
    } else {
      return null;
    }
  }

  updateData() async {
    print('RECORDID>>>>${recordId.value}');
    Map<String, String> body = {
      "RecordID": recordId.value.toString(),
      "Name": name.value.toString(),
      "CurrentlyPregnant": pregnantOrNot.value.toString(),
      "Comorbidities": listOfDiagnoses.value.toString(),
      "PeriodFirstDay": date != null
          ? DateFormat('MM/dd/yyyy').format(date!).toString()
          : date.toString(),
      "DaysinCycle": averagePeriodCycle.value.toString(),
      "Height": height.value.toString(),
      "Weight": weight.value.toString(),
      "Age": age.value.toString(),
      "Activity": activity.value.toString(),
    };
    final data = await Network()
        .updateData(email: email.value, password: password.value, body: body);

    if (data != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('userLoggedIn', true);
      prefs.setString('userRecordId', recordId.value);
      resetDetail();
      return true;
    } else {
      return false;
    }
  }
}
