part of 'system_cubit.dart';

@immutable
abstract class SystemState {}

class SystemInitial extends SystemState {}

class DoctorAuthLoading extends SystemState {}
class DoctorAuthSuccess extends SystemState {}
class DoctorAuthError extends SystemState {}

class DoctorGetAllPatientSuccess extends SystemState {}
class DoctorGetAllPatientError extends SystemState {}
class DoctorGetAllPatientLoading extends SystemState {}

class DoctorAddPatientSuccess  extends SystemState {}
class DoctorAddPatientError extends SystemState {}
class DoctorAddPatientLoading  extends SystemState {}
