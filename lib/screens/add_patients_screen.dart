import 'package:doctor_system/screens/home_screen.dart';
import 'package:doctor_system/system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/custom_textfield.dart';

class AddPatients extends StatelessWidget {
  const AddPatients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit,SystemState>(
      listener: (context,state)
      {
        if(state is DoctorAddPatientSuccess )
        {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        }
      },
        builder:(context,state)
        {
          var cubit=SystemCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Patient'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,
                          vertical: 30
                      ),
                      child: Text('Patient registration'.toUpperCase(),
                        style:const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Color(0xff1B6B93)
                        ),
                      ),
                    ),
                    CustomTextField(label: 'Patient name',
                      controller: cubit.nameController,
                    ),

                    CustomTextField(label: 'Date of Birth',
                      controller: cubit.birthController,
                    ),

                    CustomTextField(label: 'Diagnoses',
                      controller: cubit.diagnosisController,
                    ),
                    CustomTextField(label: 'Address',
                      controller: cubit.addressController,
                    ),
                    CustomTextField(label: 'Visit time',
                      controller: cubit.visitController,
                    ),

                    if(state is DoctorAddPatientLoading )

                      const Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(),
                      ),
                    GestureDetector(
                      onTap: ()
                      {
                        cubit.AddPatient();
                      },
                      child: Material(
                        color: Colors.tealAccent,
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 200,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text('Add Patient'),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
        );
  }
}
