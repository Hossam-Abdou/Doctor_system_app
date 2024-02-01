
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:doctor_system/screens/view_model/system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoot extends StatelessWidget {
final Widget startWidget;


AppRoot({required this.startWidget});

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
        home: AnimatedSplashScreen(
          splash:Image(image: AssetImage('images/doklinic.png')),
          duration: 2000,
          nextScreen:startWidget,
          backgroundColor: Colors.white,
          splashTransition: SplashTransition.slideTransition,
          curve: Curves.bounceIn,

        ),
    )
    );
  }
}
