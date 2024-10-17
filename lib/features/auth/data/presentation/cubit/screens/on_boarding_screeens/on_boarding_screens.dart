import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_app_advanced/core/database/cache/cache_helper.dart';
import 'package:to_do_app_advanced/core/utils/app_assets.dart';
import 'package:to_do_app_advanced/core/utils/app_colors.dart';
import 'package:to_do_app_advanced/core/utils/app_strings.dart';
import 'package:to_do_app_advanced/core/utils/widgets/custom_button.dart';
import 'package:to_do_app_advanced/core/utils/widgets/custom_text_button.dart';
import 'package:to_do_app_advanced/features/auth/data/model/on_boarding_model.dart';
import 'package:to_do_app_advanced/features/task/presentation/screens/home_screen/home_screen.dart';

import '../../../../../../../core/commons/commons.dart';
import '../../../../../../../core/services/service_locater.dart';

class OnBoardingScreens extends StatelessWidget {
  OnBoardingScreens({super.key});

  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: AppColors.background,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: PageView.builder(
              controller: controller,
              itemCount: OnBoardingModel.onBoardingScreens.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: index != 2
                          ? CustomTextButton(
                              text: AppStrings.skip,
                              onPressed: () {
                                controller.jumpToPage(2);
                              },
                            )
                          : SizedBox(
                              height: 50,
                            ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    // image
                    Image.asset(
                        OnBoardingModel.onBoardingScreens[index].imgPath),
                    SizedBox(
                      height: 16,
                    ),
                    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!111 dots
                    SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        activeDotColor: AppColors.primary,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),

                    SizedBox(
                      height: 52,
                    ),

                    // title
                    Text(
                      OnBoardingModel.onBoardingScreens[index].title,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    SizedBox(
                      height: 42,
                    ),

                    // subTitle
                    Text(
                      OnBoardingModel.onBoardingScreens[index].subTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(
                      height: 90,
                    ),
                    // buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // back button
                        index != 0
                            ? CustomTextButton(
                                text: AppStrings.back,
                                onPressed: () {
                                  controller.previousPage(
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.fastLinearToSlowEaseIn);
                                },
                              )
                            : Container(),
                        // next button
                        index != 2
                            ? CustomBotton(
                                text: AppStrings.next,
                                onPressed: () {
                                  controller.nextPage(
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.fastLinearToSlowEaseIn);
                                },
                              )
                            : CustomBotton(
                                text: AppStrings.getStarted,
                                onPressed: () async {
                                  // nagviget to home screen
                                  await sl<CacheHelper>()
                                      .saveData(
                                          key: AppStrings.onBoardingKey,
                                          value: true)
                                      .then((value) {
                                    print('OnBoardding is vist ');
                                    navigate(
                                        context: context, screen: HomeScreen());
                                  }).catchError((e) {
                                    print(e.toString());
                                  });
                                },
                              )
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
