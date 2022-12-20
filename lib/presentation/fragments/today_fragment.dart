import 'package:flutter/material.dart';
import 'package:mai_schedule/data/parsing/parser.dart';
import 'package:mai_schedule/data/values/my_colors.dart';
import '../../domain/day.dart';
import '../../domain/subject.dart';

class TodayFragment extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Day>>(
      future: getTodaysWeek(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<List<Day>> snapshot) {  // AsyncSnapshot<Your object type>
        if( snapshot.connectionState == ConnectionState.waiting){
          return  Center(child: Text('Please wait its loading...'));
        }else{
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            return Center(child: currentScreen(getDaysWidgets(snapshot.data??[])));
          }  // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }

 /* @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.backgroundDark,
        body: Center(
          child: Padding(
            padding:
                EdgeInsets.only(top: 64.0, left: 6.0, right: 6.0, bottom: 6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Сегодня',
                  style: TextStyle(
                    color: MyColors.backgroundGray,
                    fontSize: 40,
                  ),
                ),

                dayWidget('Big Bang'),
                dayWidget('Birth of the Sun'),
                dayWidget('Earth is Born'),
              ],
            ),
          ),
        ));*/
  }

  Widget dayWidget(Day day) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: MyColors.backgroundGray,
      child: Padding(
        padding: EdgeInsets.only(top: 8.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          collapsedIconColor: MyColors.primary,
          title: Text( // date
            day.date,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          children: getSubjectsOfDayWidgets(day.subjects),
        ),
      ),
    );
  }

List<Widget> getSubjectsOfDayWidgets(List<Subject> subjects) {
  List<Widget> list = <Widget>[];
  for(var i = 0; i < subjects.length; i++){
    list.add(subjectWidget(subjects[i]));
  }
  //return new Column(children: list);
  return list;
}

Widget getDaysWidgets(List<Day> days) {
  List<Widget> list = <Widget>[];
  for(var i = 0; i < days.length; i++){
    list.add(dayWidget(days[i]));
  }
  return new Column(children: list);
}

Widget currentScreen(Widget dataColumn){
  return Scaffold(
      backgroundColor: MyColors.backgroundDark,
      body: Center(
        child: Padding(
          padding:
          EdgeInsets.only(top: 64.0, left: 6.0, right: 6.0, bottom: 6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Сегодня',
                style: TextStyle(
                  color: MyColors.white,
                  fontSize: 40,
                ),
              ),
              Padding(padding: EdgeInsets.only(
                  top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),),
              dataColumn],
          ),
        ),
      ));
}

Widget subjectWidget(Subject subject) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
          top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
      // height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: MyColors.primary,
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
                    child: Text(
                      subject.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
                    child: Text(
                      subject.teacher,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            top: 8.0,
                            left: 8.0,
                            right: 8.0,
                            bottom: 0.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: MyColors.primaryDark,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 4.0,
                              left: 8.0,
                              right: 8.0,
                              bottom: 4.0),
                          child: Text(
                            subject.time,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 8.0,
                            left: 8.0,
                            right: 8.0,
                            bottom: 0.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: MyColors.primaryDark,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0,
                              left: 8.0,
                              right: 8.0,
                              bottom: 4.0),
                          child: Text(
                            subject.place,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              //width: double.infinity,
              // height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: MyColors.primaryDark,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    subject.type,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

class myWidgetTemplate {}
