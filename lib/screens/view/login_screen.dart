import 'package:doctor_system/components/custom_textfield.dart';
import 'package:doctor_system/screens/view_model/system_cubit.dart';
import 'package:doctor_system/screens/view/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/sp_helper/sp_helper.dart';
import '../../service/sp_helper/sp_keys.dart';
import '../view_model/system_state.dart';
import 'home_screen.dart';


class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   return BlocConsumer <SystemCubit,SystemState>(
      listener: (context,state) async{

      if(state is DoctorAuthSuccess)
        {
          SharedPrefrenceHelper.saveData(key: SharedPreferencesKeys.token, value:SystemCubit.get(context).authentication!.token).then(
                  (value)
          {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
          });

          const snackBar = SnackBar(
            content: Text('Login Successfully'),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      if(state is DoctorAuthError)
      {
        const snackBar = SnackBar(
          content: Text('Password or Email is not correct'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
        },
      builder: (context,state)
      {
        var cubit=SystemCubit.get(context);
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.white, Color(0xff92AFBDFF)],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
              appBar:AppBar(
                title: Text('Doctor App'),
                automaticallyImplyLeading: false,
                centerTitle: true,
              ),
              body:SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(20),
                        child: Image.network('https://img.freepik.com/free-vector/thank-you-doctors-nurses_52683-36502.jpg',)),
                    CustomTextField(label: 'Email',
                      controller: cubit.emailController,
                    ),
                    CustomTextField(label: 'Password',
                      controller: cubit.passwordController,
                    ),
                    if(state is DoctorAuthLoading)
                      const Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(),
                      ),
                    Material(
                      color:const Color(0xff7985ff),
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        onTap: ()
                        {
                          cubit.login();
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 200,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t Have An Account',style: TextStyle(color: Colors.black54),),
                        TextButton(
                            onPressed: ()
                            {
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ));
                            },
                            child: const Text('Register Now',style: TextStyle(color: Colors.black),)
                        )
                      ],
                    )




                  ],),
              )
          ),
        );
      },
    );
  }
}
