import 'package:get/get.dart';
import 'package:ovulu/controllers/sign_in_controller.dart';
import 'package:ovulu/controllers/sign_up_controller.dart';

void setupGetx() {
  Get.put(SignInController());
  Get.put(SignUpController());
}
