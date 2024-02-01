import 'package:bloc/bloc.dart';
import 'package:doctor_system/screens/view_model/system_state.dart';
import 'package:doctor_system/service/dio_helper/dio_helper.dart';
import 'package:doctor_system/service/sp_helper/sp_helper.dart';
import 'package:doctor_system/service/sp_helper/sp_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/auth_model.dart';
import '../model/get_patient_model.dart';


class SystemCubit extends Cubit<SystemState> {
  SystemCubit() : super(SystemInitial());

  static SystemCubit get(context) => BlocProvider.of(context);

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

  login() {
    emit(DoctorAuthLoading());
    DioHelper.postData(url: 'auth/login', data: {
      "email": emailController.text,
      "password": passwordController.text
    }).then((value) {
      authentication = AuthModel.fromJson(value.data);
      if (authentication!.code == 200) {
        emit(DoctorAuthSuccess());
      }
      SharedPrefrenceHelper.saveData(
          key: SharedPreferencesKeys.token, value: authentication!.token);

      emailController.clear();
      passwordController.clear();
    }).catchError((error) {
      emit(DoctorAuthError());
      print(error);
    });
  }

  register() {
    emit(DoctorAuthLoading());
    DioHelper.postData(url: 'auth/register', data: {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "title": titleController.text,
      "address": addressController.text
    }).then((value) {
      authentication = AuthModel.fromJson(value.data);
      if (authentication!.code == 200) {
        emit(DoctorAuthSuccess());
      }
      SharedPrefrenceHelper.saveData(
          key: SharedPreferencesKeys.token,
          value: authentication!.token
      );
          passwordController.text='';
          emailController.text='';
          nameController.text='';
          titleController.text ='';
          addressController.text='';
      print(authentication!.token);
    }).catchError((error) {
      emit(DoctorAuthError());
      print(error);
    });
  }

  AddPatient() {
    emit(DoctorAddPatientLoading());
    DioHelper.postData(url: 'doctorpatients', query: {
      "token": SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)
    }, data: {
      "name": nameController.text,
      "date_of_birth": birthController.text,
      "diagnosis": diagnosisController.text,
      "address": addressController.text,
      "visit_time": visitController.text
    }).then((value) {
      print(value.data);
      emit(DoctorAddPatientSuccess());
      authentication = AuthModel.fromJson(value.data);
      SharedPrefrenceHelper.saveData(
          key: SharedPreferencesKeys.token, value: authentication!.token);
    }).catchError((error) {
      emit(DoctorAddPatientError());
      print(error);
    });
  }

  UpdatePatient(int id) {
    emit(DoctorUpdatePatientLoading());
    DioHelper.postData(
        url: 'doctorpatients/$id?_method=put', // endpoint /id
        query: {
          "token":
              SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)
        },
        data: {
          "name": nameController.text,
          "date_of_birth": birthController.text,
          "diagnosis": diagnosisController.text,
          "address": addressController.text,
          "visit_time": visitController.text
        }).then((value) {
      print(value.data);
      emit(DoctorUpdatePatientSuccess());
    }).catchError((error) {
      emit(DoctorUpdatePatientError());
      print(error);
    });
  }

  GetAllPatient() {
    emit(DoctorGetAllPatientLoading());
    DioHelper.getData(
        url: 'doctorpatients',
        query: {
          "token": SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)
        }).then((value) {
      emit(DoctorGetAllPatientSuccess());
      getPatientModel = GetPatientModel.fromJson(value.data);
    }).catchError((error) {
      emit(DoctorGetAllPatientError());
    });
  }

  void getOnePatient(Patient patient) {
    nameController.text      = patient.name!;
    visitController.text     = patient.visitTime!;
    birthController.text     = patient.dateOfBirth!;
    addressController.text   = patient.address!;
    diagnosisController.text = patient.diagnosis!;
  }

  deletePatient(int id) {
    emit(DoctorDeletePatientLoading());
    DioHelper.deleteData(
        url: 'doctorpatients/$id',
        token: SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token))
        .then((value) {
      print(value.data);
      emit(DoctorDeletePatientSuccess());
    }).catchError((error) {
      print(error);
      emit(DoctorDeletePatientError());
    });
  }

  clearField()
  {
    nameController.clear();
    visitController.clear();
    birthController.clear();
    addressController.clear();
    diagnosisController.clear();
  }

  // delete
  // deeletePatient(int id) async {
  //   try {
  //     final token = SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token);
  //
  //     final response = await Dio().delete(
  //       'https://medicalapp.eraasoft.com/api/doctorpatients/$id',
  //       queryParameters: {'token': token},
  //     );
  //     GetAllPatient();
  //     print(response.data);
  //     // Handle success response
  //   } catch (error) {
  //     print(error);
  //     // Handle error
  //   }
  // }


// email: hossamabdou@gmail.com
// password: 1234567

// email:Abdullah@gmail.com
// password: 7654321
}
