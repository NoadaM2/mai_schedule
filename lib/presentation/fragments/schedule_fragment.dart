import 'package:flutter/material.dart';

import '../../data/values/my_colors.dart';

class ScheduleFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundDark,
      body: Center(child: Text(
          'Расписание',
      style: TextStyle(fontSize: 40, color: Colors.white),
      ),),
    );
  }
}