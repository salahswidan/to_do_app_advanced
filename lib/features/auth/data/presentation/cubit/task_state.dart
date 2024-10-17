//part of 'task_cubit.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class GetDateLoadingState extends TaskState {}

class GetDateSuccessState extends TaskState {}

class GetDateErrorState extends TaskState {}

class GetStartTimeLoadingState extends TaskState {}

class GetStartTimeSuccessState extends TaskState {}

class GetStartTimeErrorState extends TaskState {}

class GetEndTimeLoadingState extends TaskState {}

class GetEndTimeSuccessState extends TaskState {}

class GetEndTimeErrorState extends TaskState {}

class ChangeCheckMarkIndexState extends TaskState {}

class InsertTaskloadingState extends TaskState {}

class InsertTaskSucessState extends TaskState {}

class InsertTaskErrorState extends TaskState {}

class GetTaskloadingState extends TaskState {}

class GetTaskSucessState extends TaskState {}

class GetTaskErrorState extends TaskState {}

class UpdateTaskloadingState extends TaskState {}

class UpdateTaskSucessState extends TaskState {}

class UpdateTaskErrorState extends TaskState {}

class DeleteTaskloadingState extends TaskState {}

class DeleteTaskSucessState extends TaskState {}

class DeleteTaskErrorState extends TaskState {}

class GetSelectedDateLoadingState extends TaskState {}

class GetSelectedDateSuccessState extends TaskState {}

class GetSelectedDateErrorState extends TaskState {}

class ChangeThemeState extends TaskState {}
