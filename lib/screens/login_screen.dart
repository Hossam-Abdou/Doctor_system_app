import 'package:doctor_system/components/custom_textfield.dart';
import 'package:doctor_system/screens/home_screen.dart';
import 'package:doctor_system/screens/register_screen.dart';
import 'package:doctor_system/system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   return BlocConsumer <SystemCubit,SystemState>(
      listener: (context,state)
      {

      if(state is DoctorAuthSuccess)
        {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
          const snackBar = SnackBar(
            content: Text('Login Successfully'),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);        }
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
        return Scaffold(
            appBar:AppBar(
              title: Text('Doctor App'),
            ),
            body:SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(20),
                        child: Image.network('https://img.freepik.com/free-vector/thank-you-doctors-nurses_52683-36502.jpg')),
                    CustomTextField(label: 'Email',
                      controller: cubit.emailController,
                    ),
                    CustomTextField(label: 'Password',
                      isPassword: true,
                      controller: cubit.passwordController,
                    ),
                    if(state is DoctorAuthLoading)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(),
                      ),
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
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ));
                            },
                            child: const Text('Register Now')
                        )
                      ],
                    )




                  ],),
              ),
            )
        );
      },
    );
  }
}
