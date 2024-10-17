import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_advanced/core/commons/commons.dart';
import 'package:to_do_app_advanced/core/utils/app_assets.dart';
import 'package:to_do_app_advanced/core/utils/app_colors.dart';
import 'package:to_do_app_advanced/core/utils/app_strings.dart';
import 'package:to_do_app_advanced/core/utils/widgets/custom_button.dart';
import 'package:to_do_app_advanced/features/auth/data/presentation/cubit/task_cubit.dart';
import 'package:to_do_app_advanced/features/auth/data/presentation/cubit/task_state.dart';
import 'package:to_do_app_advanced/features/task/data/model/task_model.dart';

import 'add_task_screen/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // date now
                  Row(
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<TaskCubit>(context).changeTheme();
                        },
                        icon: Icon(
                          Icons.mode_night,
                          color: BlocProvider.of<TaskCubit>(context).isDark
                              ? AppColors.white
                              : AppColors.background,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  // Today
                  Text(
                    AppStrings.today,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  // date picker
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.primary,
                    selectedTextColor: Colors.white,
                    dateTextStyle: Theme.of(context).textTheme.displayMedium!,
                    dayTextStyle: Theme.of(context).textTheme.displayMedium!,
                    monthTextStyle: Theme.of(context).textTheme.displayMedium!,
                    onDateChange: (date) {
                      BlocProvider.of<TaskCubit>(context).getSelectedDate(date);
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // no tasks
                  // ! ERROR
                  BlocProvider.of<TaskCubit>(context).tasksList.isEmpty
                      ? noTasksWidget()
                      : Expanded(
                          child: ListView.builder(
                            itemCount: BlocProvider.of<TaskCubit>(context)
                                .tasksList
                                .length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    // i used to open window when i tap TaskComponent
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        padding: EdgeInsets.all(24),
                                        height: 240,
                                        color: AppColors.deepGrey,
                                        child: Column(
                                          children: [
                                            // taskCompleted
                                            // if is complelte is true delete the the taskComplete button
                                            BlocProvider.of<TaskCubit>(context)
                                                        .tasksList[index]
                                                        .isCompleted ==
                                                    1
                                                ? Container()
                                                : SizedBox(
                                                    height: 48,
                                                    width: double.infinity,
                                                    child: CustomBotton(
                                                      text: AppStrings
                                                          .taskcompleted,
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    TaskCubit>(
                                                                context)
                                                            .updateTask(BlocProvider
                                                                    .of<TaskCubit>(
                                                                        context)
                                                                .tasksList[
                                                                    index]
                                                                .id);
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: 24,
                                            ),

                                            // delete task
                                            SizedBox(
                                              height: 48,
                                              width: double.infinity,
                                              child: CustomBotton(
                                                backgroundColor: AppColors.red,
                                                text: AppStrings.deleteTask,
                                                onPressed: () {
                                                  BlocProvider.of<TaskCubit>(
                                                          context)
                                                      .deleteTask(BlocProvider
                                                              .of<TaskCubit>(
                                                                  context)
                                                          .tasksList[index]
                                                          .id);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 24,
                                            ),
                                            //cancel
                                            SizedBox(
                                              height: 48,
                                              width: double.infinity,
                                              child: CustomBotton(
                                                text: AppStrings.cancel,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: TaskComponent(
                                  taskModel: BlocProvider.of<TaskCubit>(context)
                                      .tasksList[index],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              );
            },
          ),
        ),
        //floatingActionButton
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigate(context: context, screen: AddTaskScreen());
          },
          backgroundColor: AppColors.primary,
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}

class TaskComponent extends StatelessWidget {
  const TaskComponent({
    super.key,
    required this.taskModel,
  });
  final TaskModel taskModel;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 132,
      decoration: BoxDecoration(
        color: getColor(taskModel.color),
        borderRadius: BorderRadius.circular(16),
      ),
      // Row
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //title
                Text(
                  taskModel.title,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: 8,
                ),
                //row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.timer,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${taskModel.startTime} - ${taskModel.endTime} ',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),

                //Note
                Text(
                  taskModel.note,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          // divdider
          Container(
            height: 75,
            width: 1,
            color: Colors.white,
            margin: EdgeInsets.only(right: 10),
          ),

          // text
          RotatedBox(
              // i used  RotatedBox to make the text routate after the divider
              quarterTurns: 3,
              child: Text(
                taskModel.isCompleted == 1
                    ? AppStrings.completed
                    : AppStrings.toDo,
                style: Theme.of(context).textTheme.displayMedium,
              ))
        ],
      ),
    );
  }
}

class noTasksWidget extends StatelessWidget {
  const noTasksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.noTasks),
        Text(
          '     ${AppStrings.noTaskTitle}',
          style:
              Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 24),
        ),
        Text(
          AppStrings.noTaskSubTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}
