import 'package:doctor_system/screens/login_screen.dart';
import 'package:doctor_system/system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/custom_textfield.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit,SystemState>(
      listener: (context,state)
      {
        if(state is DoctorAuthSuccess)
        {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
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
            title: Text('Register Now'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4_k_z2pnLApOaDk1QRmizy1fIt_5PpU08UV91dZRrsMNxEhuIX-NfsJKnnuJP5nXn9v0&usqp=CAU'),

                CustomTextField(label: 'UserName',
                  controller: cubit.nameController,
                ),

                CustomTextField(label: 'Email',
                  controller: cubit.emailController,
                ),

                CustomTextField(label: 'Password',
                  controller: cubit.passwordController,
                ),

                CustomTextField(label: 'Title',
                  controller: cubit.titleController,
                ),

                CustomTextField(label: 'Address',
                  controller: cubit.addressController,
                ),
                if(state is DoctorAuthLoading)
                  LinearProgressIndicator(),
                Material(
                  color: Colors.tealAccent,
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    onTap: ()
                    {
                      cubit.Register();
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 200,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text('Register'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Have An Account?'),
                    TextButton(
                        onPressed: ()
                        {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                        },
                        child: const Text('Login Now')
                    )
                  ],
                )
              ],
            ),
          ),
        );
       },
    );
  }
}
