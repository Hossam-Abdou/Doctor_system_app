import 'package:doctor_system/screens/patient_details_screen.dart';
import 'package:doctor_system/blocs/system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_patients_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SystemCubit.get(context).GetAllPatient();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit,SystemState>(
      listener: (context,state){},
        builder: (context,state)
        {
          var cubit=SystemCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('P a t i e n t s'),
              centerTitle: true,
              actions: [
                IconButton(onPressed: ()
                {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                  },
                    icon: Icon(Icons.exit_to_app))
              ],
            ),
            body: cubit.getPatientModel==null?
            const Center(
                child: CircularProgressIndicator())  :
            ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount:cubit.getPatientModel?.data?.data?.length ,
              itemBuilder: (context, int index)
                => InkWell(onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>  PatientDetails(patient: cubit.getPatientModel!.data!.data![index]),
                  ));
                },
                child:  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 45,
                        backgroundColor: Color(0xff764abc),
                        backgroundImage:NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/002/127/142/small/medicine-and-healthcare-concept-illustration-health-examination-patient-consultation-can-use-for-web-homepage-mobile-apps-web-banner-character-cartoon-illustration-flat-style-free-vector.jpg'),
                      ),
                      title: Text(cubit.getPatientModel!.data!.data![index].name!),
                      subtitle: Text(cubit.getPatientModel!.data!.data![index].diagnosis!),
                      trailing:
                          IconButton(
                            onPressed: ()
                          {
                            cubit.deletePatient(cubit.getPatientModel!.data!.data![index].id!);
                            Navigator.pushReplacement(context,MaterialPageRoute(
                              builder: (context) => const HomeScreen(), ));
                            print(cubit.getPatientModel!.data!.data![index].id!);
                          },
                              icon: Icon(Icons.delete_rounded,color: Colors.redAccent,),
                          ),
                    ) ,
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
            floatingActionButton: FloatingActionButton(


              onPressed: ()
              {
                Navigator.push(context,MaterialPageRoute(
                  builder: (context) => const AddPatients(), ));
              },
              child:const Icon(Icons.person_add) ,
            ),
          );
        },
    );
  }
}
