import 'package:flutter/material.dart';
import 'package:mai_schedule/domain/week.dart';

import '../../data/parsing/parser.dart';
import '../../data/values/my_colors.dart';
import '../../domain/day.dart';
import '../custom_widgets.dart';

class ScheduleFragment extends StatelessWidget {


  final currentWeekKey = GlobalKey();
  late Week selectedWeek;
  late List<Week> weeksGlobal;

  Future scrollToCurrentWeek() async {
    final context = currentWeekKey.currentContext!;
    await Scrollable.ensureVisible(context);
  }

  Future<List<Week>> getGlobalWeeks() async {
    List<Week> a = await getWeeks();
    weeksGlobal = a;
    return a;
  }

  Future<Week> getSelectedWeek(number) async {
    weeksGlobal = await getGlobalWeeks();
    Week res = weeksGlobal[0];
    for(Week w in weeksGlobal){
      if(w.number == number){
        return w;
      }
    }
    return res;
  }



  decider(Week week){
    selectedWeek = week;
  }

  @override
  Widget build(BuildContext context) {
    getGlobalWeeks();
    return FutureBuilder<List<Day>>(
      future: getListOfDaysSelectedWeek(getSelectedWeek("6")), // function where you call your api
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
            //scrollToCurrentWeek();
            return Center(
                child: daysCurrentWeekListScreen(getDaysWidgets(snapshot.data ?? [], true)));
          } // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }



  Widget daysCurrentWeekListScreen(Widget dataColumn){
    return
      Scaffold(
        backgroundColor: MyColors.backgroundDark,
        body: Center(
          child: Padding(
            padding:
            EdgeInsets.only(top: 64.0, left: 6.0, right: 6.0, bottom: 0.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Расписание',
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 40,
                  ),
                ),
                weeeek(currentWeekKey),
                Expanded(child: dataColumn),
              ],
            ),
          ),
        ),
      );
  }


  Widget weeeek(currentWeekKey) {
    return weeksListContainer(weeksGlobal, currentWeekKey);
  }

  Widget createWeeksRow(List<Week> weeks, currentWeekKey) {
    List<Widget> weeksWidgets = [];
    for(Week week in weeks){
      weeksWidgets.add(weekWidget(week, currentWeekKey));
    }
    return Row(children: weeksWidgets);
  }

  Widget weeksListContainer(List<Week> weeks, currentWeekKey) {
    return Container(
      width: double.infinity,
      //  height: 52,
      margin: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: MyColors.backgroundGray,
      ),
      //color: MyColors.backgroundGray,
      child: Padding(
        padding: EdgeInsets.only(top: 8.0, left: 6.0, right: 6.0, bottom: 6.0),
        child:
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: createWeeksRow(weeks, currentWeekKey)),
      ),
    );
  }

  Widget weekWidget(Week week, currentWeekKey){
    Color color = MyColors.primary;
    if(week.type == "current"){
      decider(week);
      color = MyColors.purple;
      return Container(
        key: currentWeekKey,
        margin: EdgeInsets.all(4.0),
        // width: 24,
        //  height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90.0),
          color: color,
          // border: Border.all(color: border_color, width: 2)
        ),
        child: Align(
          alignment: Alignment.center,
          child:  Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: Text(
              week.range,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }
    return InkWell(
      onTap: (() {
        setState(){
          decider(week);
        }
        print("pressed: "+week.range);
      }),
      child: Container(
        margin: EdgeInsets.all(4.0),
        // width: 24,
        //  height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90.0),
          color: color,
          // border: Border.all(color: border_color, width: 2)
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: Text(
              week.range,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),

          ),
        ),
      ),
    );
  }


}
