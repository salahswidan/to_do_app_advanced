// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:meta/meta.dart';
// import 'package:to_do_app_advanced/features/auth/data/presentation/cubit/task_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'task_state.dart';

// class TaskCubit extends Cubit<TaskState> {
//   TaskCubit() : super(TaskInitial());

//   DateTime currentDate = DateTime.now();
//   String startTime = DateFormat('hh:mm a').format(DateTime.now());
//   String endTime =
//       DateFormat('hh:mm a').format(DateTime.now().add(Duration(minutes: 45)));

//   int currentIndex = 0;

//   void getDate(context) async {
//     emit(GetDateLoadingState() );
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2025),
//     );

//     if (pickedDate != null) {
//       currentDate = pickedDate;
//       emit(GetDateSuccessState() as TaskState);
//     } else {
//       print('PickedDate == null');
//     }
//   }
// }
