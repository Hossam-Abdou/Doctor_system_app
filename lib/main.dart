import 'package:doctor_system/screens/login_screen.dart';
import 'package:doctor_system/service/dio_helper/dio_helper.dart';
import 'package:doctor_system/service/sp_helper/sp_helper.dart';
import 'package:doctor_system/service/sp_helper/sp_keys.dart';
import 'package:doctor_system/src/app_root.dart';
import 'package:flutter/material.dart';

main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await SharedPrefrenceHelper.init();
  runApp( AppRoot() );
}