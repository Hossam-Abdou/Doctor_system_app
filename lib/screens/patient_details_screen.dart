import 'package:flutter/material.dart';

import '../model/get_patient_model.dart';

class PatientDetails extends StatelessWidget {
  final Patient patient;

  PatientDetails({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                 backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMbYrXlQ-yEc3NZjomedQBX787pIzKrgudFQ&usqp=CAU'),
              ),
              Text('patient name'),
            ],
          ),
        ),
      ),
    );
  }
}
