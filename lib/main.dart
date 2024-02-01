import 'package:bloc/bloc.dart';
import 'package:doctor_system/screens/view/home_screen.dart';
import 'package:doctor_system/screens/view/login_screen.dart';
import 'package:doctor_system/service/dio_helper/dio_helper.dart';
import 'package:doctor_system/service/sp_helper/sp_helper.dart';
import 'package:doctor_system/service/sp_helper/sp_keys.dart';
import 'package:doctor_system/src/app_root.dart';
import 'package:flutter/material.dart';
import 'blocs/bloc_observer.dart';

main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await SharedPrefrenceHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget? widget;
  if(SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)!=null){
    widget=HomeScreen();
  }else{
    widget=LoginScreen();
  }
  runApp( AppRoot(startWidget:widget) );
}