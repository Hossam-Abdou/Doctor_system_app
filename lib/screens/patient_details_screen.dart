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
                    color: Color(0xff1B6B93),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xff764abc),
                          backgroundImage: NetworkImage(
                              'https://static.vecteezy.com/system/resources/thumbnails/002/127/142/small/medicine-and-healthcare-concept-illustration-health-examination-patient-consultation-can-use-for-web-homepage-mobile-apps-web-banner-character-cartoon-illustration-flat-style-free-vector.jpg'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              patient.name!,
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.white),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              patient.diagnosis!,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
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
                  Material(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.circular(45),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UpdatePatientScreen(
                                      patientId: patient.id!,

                                    )
                            )
                        );
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 160,
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text('Update Patient'),
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
