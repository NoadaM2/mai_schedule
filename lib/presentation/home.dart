import 'package:flutter/material.dart';

import '../data/values/my_colors.dart';
import 'fragments/homework_fragment.dart';
import 'fragments/news_fragment.dart';
import 'fragments/profile_fragment.dart';
import 'fragments/schedule_fragment.dart';
import 'fragments/today_fragment.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int bottomNavigationBar_currentIndex = 0;
  final fragments = [
    TodayFragment(),
    ScheduleFragment(),
    HomeworkFragment(),
    NewsFragment(),
    ProfileFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: fragments[bottomNavigationBar_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavigationBar_currentIndex,
        onTap: (index) => setState(() {
          bottomNavigationBar_currentIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.today),
            label: 'Сегодня',
            backgroundColor: MyColors.backgroundGray,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
            label: 'Расписание',
            backgroundColor: MyColors.backgroundGray,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.task),
            label: 'Домашка',
            backgroundColor: MyColors.backgroundGray,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
            label: 'Новости',
            backgroundColor: MyColors.backgroundGray,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
            label: 'Профиль',
            backgroundColor: MyColors.backgroundGray,
          ),
        ],
      ),
    );
  }
}