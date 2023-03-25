import 'package:flutter/material.dart';
import 'package:mai_schedule/data/parsing/parser.dart';
import 'package:mai_schedule/data/values/my_colors.dart';
import '../../domain/day.dart';
import '../../domain/subject.dart';
import '../../domain/week.dart';
import '../../presentation/fragments/schedule_fragment.dart';
// import 'package:fluttertoast/fluttertoast.dart';



Widget dayWidget(Day day) {
  return Container(
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      color: MyColors.backgroundGray,
    ),
    //color: MyColors.backgroundGray,
    child: Padding(
      padding: EdgeInsets.only(top: 8.0, left: 6.0, right: 6.0, bottom: 6.0),
      child: ExpansionTile(
        initiallyExpanded : day.isToday(),
        collapsedIconColor: MyColors.primary,
        title: Row( children:<Widget>[ Text( // date
          day.date,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
          dayIndexesWidget(day),
        ]),
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

Widget dayIndexesWidget(Day day) {
  day.CountIndexes();
  List<Widget> w = [];
  if (day.lr_count > 0){ w.add(lrIndexWidget(day));}
  if (day.pz_count > 0){ w.add(pzIndexWidget(day));}
  if (day.lk_count > 0){ w.add(lkIndexWidget(day));}
  if (day.ekz_count > 0){ w.add(ekzIndexWidget(day));}
  return Padding(
    padding: EdgeInsets.only(top: 0.0, left: 8.0, right: 0.0, bottom: 0.0),
    child: Row(
      children: w,
    ),);
}

Widget lrIndexWidget(Day day) {
  Color color = MyColors.purple;
  Color border_color = MyColors.purple;
  bool filled = false;
  return Container(
    margin: EdgeInsets.all(2.0),
    width: 24,
    height: 24,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
        color: color,
        border: Border.all(color: border_color, width: 2)
    ),
    child: Align(
      alignment: Alignment.center,
      child: Text(
        day.lr_count.toString(),
        style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),

    ),
  );
}

Widget lkIndexWidget(Day day) {
  Color color = MyColors.backgroundGray;
  Color border_color = MyColors.primaryDark;
  bool filled = false;
  return Container(
    margin: EdgeInsets.all(2.0),
    width: 24,
    height: 24,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
        color: color,
        border: Border.all(color: border_color, width: 2)
    ),
    child: Align(
      alignment: Alignment.center,
      child: Text(
        day.lk_count.toString(),
        style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),

    ),
  );
}

Widget ekzIndexWidget(Day day) {
  Color color = MyColors.backgroundGray;
  Color border_color = MyColors.red;
  bool filled = false;
  return Container(
    margin: EdgeInsets.all(2.0),
    width: 24,
    height: 24,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
        color: color,
        border: Border.all(color: border_color, width: 2)
    ),
    child: Align(
      alignment: Alignment.center,
      child: Text(
        day.ekz_count.toString(),
        style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),

    ),
  );
}

Widget pzIndexWidget(Day day) {
  Color color = MyColors.primaryDark;
  Color border_color = MyColors.primaryDark;
  bool filled = false;
  return Container(
    margin: EdgeInsets.all(2.0),
    width: 24,
    height: 24,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
        color: color,
        border: Border.all(color: border_color, width: 2)
    ),
    child: Align(
      alignment: Alignment.center,
      child: Text(
        day.pz_count.toString(),
        style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),

    ),
  );
}

Widget subjectWidget(Subject subject) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(
        top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
    // height: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      color: MyColors.primary,
    ),
    child: Padding(
      padding: EdgeInsets.only(
          top: 8.0, left: 8.0, right: 16.0, bottom: 8.0),
      child: Row( // Type and other
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
          typeWidget(subject),
        ],
      ),
    ),
  );
}




Widget typeWidget(Subject subject) {
  Color color = MyColors.white;
  Color border_color = MyColors.white;
  bool filled = false;
  switch(subject.type){
    case "ЛК":
      color = MyColors.primary;
      border_color = MyColors.primaryDark;
      filled = false;
      break;
    case "ПЗ":
      color = MyColors.primaryDark;
      border_color = MyColors.primaryDark;
      filled = true;
      break;
    case "ЛР":
      color = MyColors.purple;
      border_color = MyColors.purple;
      filled = true;
      break;
    case "ЭКЗ":
      color = MyColors.primary;
      border_color = MyColors.red;
      filled = true;
      break;
  }

  return Container(
    //width: double.infinity,
    // height: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
        border: Border.all(color: border_color, width: 2)
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
  );
}

Widget daysListScreen(Widget dataColumn){
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
                'Сегодня',
                style: TextStyle(
                  color: MyColors.white,
                  fontSize: 40,
                ),
              ),
              Expanded(child: dataColumn),
            ],
          ),
        ),
      ),
    );
}


Widget getDaysWidgets(List<Day> days, bool today) {
  if (!today){
    days.forEach((e) {
      if(e.type == "today"){
        e.changeType("usual");
      }
    });
  }
  return ListView.builder(
    physics: BouncingScrollPhysics(),
    itemCount: days.length,
    itemBuilder: (BuildContext context, int index) {
      return dayWidget(days[index]);
    },
  );
}


Widget centerText(String text) {
  return Scaffold(
    backgroundColor: MyColors.backgroundDark,
    body: Center(child: Text(
      text,
      style: TextStyle(fontSize: 40, color: Colors.white),
    ),),
  );
}