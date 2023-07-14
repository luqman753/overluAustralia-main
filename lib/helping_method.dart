import 'package:connectivity/connectivity.dart';

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    print('IF>>>>$connectivityResult');
    return false;
  } else {
    print('ELSE>>>> $connectivityResult');
    return true;
  }
}
