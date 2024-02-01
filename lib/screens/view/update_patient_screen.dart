import 'package:doctor_system/screens/view_model/system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/second_custom_textfield.dart';
import '../view_model/system_state.dart';
import 'home_screen.dart';

class UpdatePatientScreen extends StatelessWidget {

  final int patientId;


  UpdatePatientScreen({required this.patientId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit,SystemState>(
      listener: (context,state)
      {
        if(state is DoctorUpdatePatientSuccess )
        {
          Navigator.pushReplacement(context,
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
            title: const Text('Edit'),
            centerTitle: true
            ,
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,
                        vertical: 30
                    ),
                    child: Text('Edit Patient Details'.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Color(0xff1B6B93)
                      ),
                    ),
                  ),
                  SecondCustomTextField(label: 'Patient name',
                    controller: cubit.nameController,
                  ),

                  SecondCustomTextField(label: 'Date of Birth',
                    controller: cubit.birthController,
                  ),

                  SecondCustomTextField(label: 'Diagnoses',
                    controller: cubit.diagnosisController,
                  ),
                  SecondCustomTextField(
                    label: 'Address',
                    controller: cubit.addressController,
                  ),
                  SecondCustomTextField(label: 'Visit time',
                    controller: cubit.visitController,
                  ),

                  if(state is DoctorUpdatePatientLoading )

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    ),
                  GestureDetector(
                    onTap: ()
                    {
                      cubit.UpdatePatient(patientId);
                      print(patientId);

                    },
                    child: Material(
                      color: Color(0xff7985ff),
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 200,
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text('Update',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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
