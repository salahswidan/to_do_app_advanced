import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app_advanced/features/auth/data/presentation/cubit/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/database/cache/sqflite_helper/sqflite_helper.dart';
import '../../../../../core/services/service_locater.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../task/data/model/task_model.dart';

//part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  DateTime currentDate = DateTime.now();
  DateTime SelectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime =
      DateFormat('hh:mm a').format(DateTime.now().add(Duration(minutes: 45)));

  int currentIndex = 0;
  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

//! get Date From User

  void getDate(context) async {
    emit(GetDateLoadingState());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      currentDate = pickedDate;
      emit(GetDateSuccessState());
    } else {
      print('PickedDate == null');
    }
  }

  void getStartTime(context) async {
    emit(GetStartTimeLoadingState());
    TimeOfDay? PickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (PickedStartTime != null) {
      startTime = PickedStartTime.format(context);
      emit(GetStartTimeSuccessState());
    } else {
      print('pickedStartTime = null');
      emit(GetStartTimeErrorState());
    }
  }

  void getEndTime(context) async {
    emit(GetEndTimeLoadingState());
    TimeOfDay? PickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (PickedEndTime != null) {
      endTime = PickedEndTime.format(context);
      emit(GetEndTimeSuccessState());
    } else {
      print('pickedEndTime = null');
      emit(GetEndTimeErrorState());
    }
  }

  Color? getColor(index) {
    switch (index) {
      case 0:
        return AppColors.red;
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.blueGrey;
      case 3:
        return AppColors.blue;
      case 4:
        return AppColors.orange;
      case 5:
        return AppColors.purple;
      default:
        return AppColors.grey;
    }
  }

  void getSelectedDate(date) {
    emit(GetSelectedDateLoadingState());
    SelectedDate = date;
    emit(GetSelectedDateSuccessState());
    getTasks();
  }

  void changeCheckMarkIndex(index) {
    currentIndex = index;
    emit(ChangeCheckMarkIndexState());
  }

  List<TaskModel> tasksList = [];

  void insertTask() async {
    emit(InsertTaskloadingState());
    try {
      await sl<SqfliteHelper>().insertToDB(
        TaskModel(
          title: titleController.text,
          note: noteController.text,
          startTime: startTime,
          endTime: endTime,
          isCompleted: 0,
          date: DateFormat.yMd().format(currentDate),
          color: currentIndex,
        ),
      );
      getTasks();
      //! To make screen wait 2 sce
      // await Future.delayed(Duration(seconds: 3));
      // tasksList.add(TaskModel(

      // ));
      titleController.clear(); // to male clear to the field when it pop
      noteController.clear();
      emit(InsertTaskSucessState());
    } catch (e) {
      emit(InsertTaskErrorState());
    }
  }

//! get Tasks
  void getTasks() async {
    emit(GetDateLoadingState());
    await sl<SqfliteHelper>().getFromDB().then((value) {
      tasksList = value
          .map((e) => TaskModel.fromJson(e))
          .toList()
          .where(
            (element) => element.date == DateFormat.yMd().format(SelectedDate),
          )
          .toList();
      emit(GetDateSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetDateErrorState());
    });
  }

  //! update Task
  void updateTask(id) async {
    emit(UpdateTaskloadingState());
    await sl<SqfliteHelper>().updatedDB(id).then((value) {
      emit(UpdateTaskSucessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(UpdateTaskErrorState());
    });
  }

  //! delete Task
  void deleteTask(id) async {
    emit(DeleteTaskloadingState());
    await sl<SqfliteHelper>().deleteFromDB(id).then((value) {
      emit(DeleteTaskSucessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(DeleteTaskErrorState());
    });
  }

  bool isDark = true;
  void changeTheme() {
    isDark = !isDark;
    emit(ChangeThemeState());
  }
}
