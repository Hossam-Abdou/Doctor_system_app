import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doctor_system/screens/home_screen.dart';
import 'package:doctor_system/screens/update_patient_screen.dart';
import 'package:doctor_system/service/dio_helper/dio_helper.dart';
import 'package:doctor_system/service/sp_helper/sp_helper.dart';
import 'package:doctor_system/service/sp_helper/sp_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'model/auth_model.dart';
import 'model/get_patient_model.dart';

part 'system_state.dart';

class SystemCubit extends Cubit<SystemState> {
  SystemCubit() : super( SystemInitial() );

  static SystemCubit get (context)=>BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController diagnosisController = TextEditingController();
  TextEditingController visitController = TextEditingController();
  TextEditingController birthController = TextEditingController();

  AuthModel? authentication;
  GetPatientModel? getPatientModel;
  UpdatePatientScreen? patient;


  Login() {
    emit(DoctorAuthLoading());
    DioHelper.postData(
        url:'auth/login',
        data: {
      "email": emailController.text,
      "password": passwordController.text
    }).then((value) {

      authentication=AuthModel.fromJson(value.data);
      if(authentication!.code==200){
        emit(DoctorAuthSuccess());

      }
      SharedPrefrenceHelper.saveData(
          key: SharedPreferencesKeys.token,
          value: authentication!.token);

      emailController.clear();
      passwordController.clear();
    }).catchError((error) {
      emit(DoctorAuthError());
      print(error);
    });
  }
  Register(){
    DioHelper.postData(
        url: 'auth/register',
        data: {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "title":  titleController.text,
      "address":addressController.text
    }).then((value) {
      if(authentication!.code==200) {
        emit(DoctorAuthSuccess());
      }
      authentication = AuthModel.fromJson(value.data);
      print(authentication!.token);

    }).catchError((error) {
      emit(DoctorAuthError());
      print(error);
    });
  }
  AddPatient(){
    emit(DoctorAddPatientLoading());
    DioHelper.postData(
        url: 'doctorpatients',
        query: {
          "token":SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)
        },
        data: {
          "name":nameController.text,
          "date_of_birth":birthController.text,
          "diagnosis":diagnosisController.text,
          "address":addressController.text,
          "visit_time":visitController.text
        }).then((value) {
      print(value.data);
      emit(DoctorAddPatientSuccess());
      authentication= AuthModel.fromJson(value.data);
      SharedPrefrenceHelper.saveData(
          key: SharedPreferencesKeys.token,
          value: authentication!.token
      );
    }).catchError((error){
      emit(DoctorAddPatientError());
      print(error);
    });
  }
  UpdatePatient(){
    emit(DoctorUpdatePatientLoading());
    DioHelper.putData(
        url: 'doctorpatients',
        query: {
          "token":SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)
        },
        data: {
          "name":nameController.text,
          "date_of_birth":birthController.text,
          "diagnosis":diagnosisController.text,
          "address":addressController.text,
          "visit_time":visitController.text
        }).then((value) {
      print(value.data);
      emit(DoctorUpdatePatientSuccess());
      authentication= AuthModel.fromJson(value.data);
      SharedPrefrenceHelper.saveData(
          key: SharedPreferencesKeys.token,
          value: authentication!.token
      );
    }).catchError((error){
      emit(DoctorUpdatePatientError());
      print(error);
    });
  }


  Future<void> deletePost(postId) async {
    var postUrl = 'https://medicalapp.eraasoft.com/api/doctorpatients';

    Dio dio = Dio();
    dio.options.headers['Content-type'] = 'application/json; charset=UTF-8';

    try {
      final response = await dio.delete(postUrl);
      // ignore: use_build_context_synchronously
      Navigator.pop(HomeScreen() as BuildContext);
      // ignore: use_build_context_synchronously
      debugPrint('post : ${response.data}');
      debugPrint('message : ${response.statusMessage}');
    } catch (e) {
      debugPrint('exception $e');
    }
  }

  GetAllPatient(){
    emit(DoctorGetAllPatientLoading());
    DioHelper.getData(
      url: 'doctorpatients',
        query: {
          "token": SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)
        }).then((value) {
          emit(DoctorGetAllPatientSuccess());
          getPatientModel= GetPatientModel.fromJson(value.data);
    }).catchError((error){

      emit(DoctorGetAllPatientError());

    });
  }

   deletePatient(String patientId) async {
    try {
      final token = SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token);

      final response = await Dio().delete(
        'https://your_api_url.com/doctorpatients/$patientId',
        queryParameters: {'token': token},
      );

      print(response.data);
      // Handle success response
    } catch (error) {
      print(error);
      // Handle error
    }
  }

}
