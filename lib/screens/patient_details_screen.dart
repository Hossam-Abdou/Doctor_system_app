import 'package:doctor_system/screens/update_patient_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/get_patient_model.dart';
import '../blocs/system_cubit.dart';

class PatientDetails extends StatelessWidget {
  final Patient patient;

  PatientDetails({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: SystemCubit.get(context)..getOnePatient(patient),
      child: BlocConsumer<SystemCubit, SystemState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('P r o f i l e'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      color: Color(0xffc4caf6),
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            radius: 49,
                            backgroundColor: Colors.black,
                            child:  CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(
                                  'https://static.vecteezy.com/system/resources/thumbnails/002/127/142/small/medicine-and-healthcare-concept-illustration-health-examination-patient-consultation-can-use-for-web-homepage-mobile-apps-web-banner-character-cartoon-illustration-flat-style-free-vector.jpg'),
                            ),
                          ),
                          Text(
                            patient.name!,
                            style: const TextStyle(
                                fontSize: 24, color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              patient.diagnosis!,
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black,fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: Column(
                      children: [

                      const Text(
                        'Date of Birth:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        patient.dateOfBirth!,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Address:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        patient.address!,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Visit Time:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        patient.visitTime!,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],),
                  ),
                  SizedBox(height: 50,),
                  Center(
                    child: Material(
                      color: Color(0xff7985ff),
                      borderRadius: BorderRadius.circular(45),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdatePatientScreen(
                                        patientId: patient.id!,
                                      ))
                          );},
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 190,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text('Update Patient',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
