import 'package:flutter/material.dart';
import 'package:mai_schedule/data/parsing/parser.dart';
import 'package:mai_schedule/data/values/my_colors.dart';
import '../../domain/day.dart';
import '../../domain/subject.dart';
import '../../domain/week.dart';
import '../custom_widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';


class TodayFragment extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Day>>(
      future: getListOfDaysTodaysWeek(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<
          List<Day>> snapshot) { // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child:
              centerText('Загрузка...'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            return Center(
                child: daysListScreen(getDaysWidgets(snapshot.data ?? [], true)));
          } // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }

}
