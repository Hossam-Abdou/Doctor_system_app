import 'package:doctor_system/screens/register_screen.dart';
import 'package:doctor_system/blocs/system_cubit.dart';
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
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Color(0xff7985ff)),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor:Color(0xff7985ff) ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
      ),
      debugShowCheckedModeBanner: false,
        home: RegisterScreen()
    )
    );
  }
}
