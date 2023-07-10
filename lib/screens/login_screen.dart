import 'package:doctor_system/components/custom_textfield.dart';
import 'package:doctor_system/screens/home_screen.dart';
import 'package:doctor_system/screens/register_screen.dart';
import 'package:doctor_system/system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer <SystemCubit,SystemState>(
      listener: (context,state)
      {
        if(state is DoctorAuthSuccess)
        {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
          print('congrats email is correct');
        }else if(state is DoctorAuthError)
        {
          print('error');
        }
        },
      builder: (context,state)
      {
        var cubit=SystemCubit.get(context);
        return Scaffold(
            appBar:AppBar(
              title: Text('Doctor App'),
            ),
            body:SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(25),
                      child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeydRp2LsRCYcJQ9SqH4r6rKGN1JGsnB62Y-xjj791z-fMr9FCJmST47VNgC3NHK-kGyI&usqp=CAU')),
                  CustomTextField(label: 'Email',
                    controller: cubit.emailController,
                  ),
                  CustomTextField(label: 'Password',
                    isPassword: true,
                    controller: cubit.passwordController,
                  ),


                  if(state is DoctorAuthLoading)
                    LinearProgressIndicator(),
                  Material(
                    color: Colors.tealAccent,
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
                        child: Text('Login',),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t Have An Account'),
                      TextButton(
                          onPressed: ()
                          {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ));
                          },
                          child: const Text('Register Now')
                      )
                    ],
                  )
                  
                  


                ],),
            )
        );
      },
    );
  }
}
