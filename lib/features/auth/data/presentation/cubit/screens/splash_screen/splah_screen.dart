import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app_advanced/core/database/cache/cache_helper.dart';
import 'package:to_do_app_advanced/core/utils/app_assets.dart';
import 'package:to_do_app_advanced/core/utils/app_colors.dart';
import 'package:to_do_app_advanced/core/utils/app_strings.dart';
import 'package:to_do_app_advanced/features/auth/data/presentation/cubit/screens/on_boarding_screeens/on_boarding_screens.dart';
import 'package:to_do_app_advanced/features/task/presentation/screens/home_screen/home_screen.dart';

import '../../../../../../../core/services/service_locater.dart';

class SplahScreen extends StatefulWidget {
  const SplahScreen({super.key});

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() {
    bool isvisited =
        sl<CacheHelper>().getData(key: AppStrings.onBoardingKey) ?? false;

    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => isvisited ? HomeScreen() : OnBoardingScreens(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.logo),
            SizedBox(
              height: 24,
            ),
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize:
                        40, // i used copy with because i make extended from displatlarge font size 32 but i need 40 here
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
