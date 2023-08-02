import 'package:doctor_system/components/custom_textfield.dart';
import 'package:doctor_system/screens/home_screen.dart';
import 'package:doctor_system/screens/register_screen.dart';
import 'package:doctor_system/blocs/system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/sp_helper/sp_helper.dart';
import '../service/sp_helper/sp_keys.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   return BlocConsumer <SystemCubit,SystemState>(
      listener: (context,state) async{

      if(state is DoctorAuthSuccess)
        {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
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
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Colors.black54, Color(0xff92AFBDFF)],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
              appBar:AppBar(
                title: Text('Doctor App'),
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
                          cubit.Login();
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
                        Text('Don\'t Have An Account',style: TextStyle(color: Colors.white),),
                        TextButton(
                            onPressed: ()
                            {
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ));
                            },
                            child: const Text('Register Now',style: TextStyle(color: Colors.white),)
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
