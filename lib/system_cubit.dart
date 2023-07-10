import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doctor_system/service/dio_helper/dio_helper.dart';
import 'package:doctor_system/service/sp_helper/sp_helper.dart';
import 'package:doctor_system/service/sp_helper/sp_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'model/add_patient_model.dart';
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
  AddPatientModel? addPatientModel;
  GetPatientModel? getPatientModel;

  Login() {
    emit(DoctorAuthLoading());
    DioHelper.postData(url: 'auth/login', data: {
      "email": emailController.text,
      "password": passwordController.text
    }).then((value) {
      emit(DoctorAuthSuccess());
      authentication=AuthModel.fromJson(value.data);
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
    DioHelper.postData(url: 'auth/register', data: {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "title":  titleController.text,
      "address":addressController.text
    }).then((value) {
      emit(DoctorAuthSuccess());
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
