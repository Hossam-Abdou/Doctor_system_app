import 'package:doctor_system/screens/view_model/system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/custom_textfield.dart';
import '../view_model/system_state.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) async {
        if (state is DoctorAuthSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
          const snackBar = SnackBar(
            content: Text('Registered Successfully'),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is DoctorAuthError) {
          const snackBar = SnackBar(
            content: Text('Error'),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var cubit = SystemCubit.get(context);
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
            appBar: AppBar(
              title: Text('Register Now'),
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://img.freepik.com/free-vector/medical-video-call-consultation-illustration_88138-415.jpg',
                        width: double.infinity,
                      )),
                  CustomTextField(
                    label: 'UserName',
                    controller: cubit.nameController,
                  ),
                  CustomTextField(
                    label: 'Email',
                    controller: cubit.emailController,
                  ),
                  CustomTextField(
                    label: 'Password',
                    controller: cubit.passwordController,
                    isPassword: true,
                  ),
                  CustomTextField(
                    label: 'Title',
                    controller: cubit.titleController,
                  ),
                  CustomTextField(
                    label: 'Address',
                    controller: cubit.addressController,
                  ),
                  if (state is DoctorAuthLoading)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    ),
                  Material(
                    color:const Color(0xff7985ff),
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      onTap: () {
                        cubit.register();
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 200,
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text('Register',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have An Account?',
                        style: TextStyle(color: Colors.black54),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          },
                          child: const Text(
                            'Login Now',
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
