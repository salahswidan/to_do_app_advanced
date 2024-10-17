import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_advanced/core/commons/commons.dart';
import 'package:to_do_app_advanced/core/utils/app_colors.dart';
import 'package:to_do_app_advanced/core/utils/app_strings.dart';
import 'package:to_do_app_advanced/core/utils/widgets/custom_button.dart';
import 'package:to_do_app_advanced/features/task/cubit/task_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_advanced/features/task/data/model/task_model.dart';
import '../../../../../auth/data/presentation/components/add_task_component.dart';
import '../../../../../auth/data/presentation/cubit/task_cubit.dart';
import '../../../../../auth/data/presentation/cubit/task_state.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          AppStrings.addTask,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
              if (state is InsertTaskSucessState) {
                // ! text show it pop
                showToast(
                    message: 'Added Suceefully', state: ToastStates.success);

                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Form(
                key: BlocProvider.of<TaskCubit>(context).formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // !title
                    AddTaskComponent(
                      controller:
                          BlocProvider.of<TaskCubit>(context).titleController,
                      title: AppStrings.title,
                      hintText: AppStrings.titleHint,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter valid Title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    // ! note
                    AddTaskComponent(
                      controller:
                          BlocProvider.of<TaskCubit>(context).noteController,
                      title: AppStrings.note,
                      hintText: AppStrings.notehint,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter valid note';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    // ! data
                    AddTaskComponent(
                      controller:
                          BlocProvider.of<TaskCubit>(context).noteController,
                      title: AppStrings.date,
                      hintText: DateFormat.yMd().format(
                          BlocProvider.of<TaskCubit>(context).currentDate),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          BlocProvider.of<TaskCubit>(context).getDate(context);
                        },
                        icon: Icon(
                          Icons.calendar_month_rounded,
                          color: AppColors.white,
                        ),
                      ),
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    // ! start  - end time
                    Row(
                      children: [
                        Expanded(
                          //! start
                          child: AddTaskComponent(
                            readOnly: true,
                            title: AppStrings.startTime,
                            hintText:
                                BlocProvider.of<TaskCubit>(context).startTime,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                BlocProvider.of<TaskCubit>(context)
                                    .getStartTime(context);
                              },
                              icon: Icon(
                                Icons.timer_outlined,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 26.w,
                        ),
                        Expanded(
                          //! end
                          child: AddTaskComponent(
                            readOnly: true,
                            title: AppStrings.endTime,
                            hintText:
                                BlocProvider.of<TaskCubit>(context).endTime,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                BlocProvider.of<TaskCubit>(context)
                                    .getEndTime(context);
                              },
                              icon: Icon(
                                Icons.timer_outlined,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    //! color
                    SizedBox(
                      height: 68.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.color,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Expanded(
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              separatorBuilder: (context, index) => SizedBox(
                                width: 8.w,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<TaskCubit>(context)
                                        .changeCheckMarkIndex(index);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        BlocProvider.of<TaskCubit>(context)
                                            .getColor(index),
                                    child: index ==
                                            BlocProvider.of<TaskCubit>(context)
                                                .currentIndex
                                        ? Icon(Icons.check)
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //! Add Task button
                    //     Spacer(),
                    SizedBox(
                      height: 90.h,
                    ),
                    state is InsertTaskloadingState
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : SizedBox(
                            height: 48.h,
                            width: double.infinity,
                            child: CustomBotton(
                              text: AppStrings.createTask,
                              onPressed: () {
                                if (BlocProvider.of<TaskCubit>(context)
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  BlocProvider.of<TaskCubit>(context)
                                      .insertTask();
                                }
                              },
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
