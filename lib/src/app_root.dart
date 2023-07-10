import 'package:doctor_system/screens/home_screen.dart';
import 'package:doctor_system/screens/login_screen.dart';
import 'package:doctor_system/system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoot extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:
        [
        BlocProvider(create: (context)=>SystemCubit())
        ],
    child:  MaterialApp(
      debugShowCheckedModeBanner: false,
        home: LoginScreen()
    )
    );
  }
}
