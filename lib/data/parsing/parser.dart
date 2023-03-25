import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import '../../domain/day.dart';
import '../../domain/department.dart';
import '../../domain/subject.dart';
import '../../data/converter/visualizer.dart';
import '../../domain/week.dart';

String groupUrl = 'https://mai.ru/education/studies/schedule/index.php?group=М3О-209Б-21';
// String groupUrl1 = 'https://mai.ru/education/studies/schedule/index.php?group=М3О-223Б-21&week=2';

String dateClassHtml = 'step-title ms-3 ms-sm-0 mt-2 mb-4 mb-sm-2 py-1 text-body';
String todayDateClassHtml = "step-title ms-3 ms-sm-0 mt-2 mb-4 mb-sm-2 py-1 text-primary";

String subjectClassHtml = "mb-4";
String subjectNameClassHtml = "d-flex align-items-center justify-content-between";
String subjectInfoClassHtml = "list-inline list-separator text-body small";
String subjectTypeClassHtml = 'badge bg-soft-secondary text-secondary ms-2 fw-medium text-smaller';

String weekClassHtml = "list-group-item d-flex";

Future<List<Week>> getWeeks() async {
  List<Week> weeks = [];
  final response =
      await http.Client().get(Uri.parse(groupUrl));
  if (response.statusCode == 200) {
    var document = parse(response.body);
    List<Element> days = document.getElementsByClassName(weekClassHtml);
    for(Element d in days){
      String addInfo = d.getElementsByClassName('badge bg-soft-dark text-dark ms-2')[0].text;
      String addInfo1 = d.getElementsByClassName('w-100 d-block text-center')[0].text;
        List<Element> addInfo2 = d.getElementsByClassName('w-100')[0].children;
        String number,range,type = 'current';
        if (addInfo2.length == 1){
          type = 'usual';
        }
      number = addInfo;
      range = addInfo1;
      weeks.add(Week(number: number, range: range, type: type));
    }

  return weeks;
  } else {
    throw Exception();
  }
}

var visualiser = Visualizer();

Day getTodayDay(List<Element> days){
  String todayDate = visualiser.formatNewLines(days[0].getElementsByTagName('span')[0].text);
  List<Element> subjects = days[0].getElementsByClassName(subjectClassHtml);
  subjects.remove(subjects[0]);

  List<Subject> subjectsR = [];

  for (var subject in subjects) {
    subjectsR.add(visualiser.subjectFromHTML(subject));
  }
  Day a = Day(date: todayDate, subjects: subjectsR, type: 'today');
  return a;
}

Future<List<Day>> getListOfDaysTodaysWeek() async {
  final response =
  await http.Client().get(Uri.parse(groupUrl));
  if (response.statusCode == 200) {
    var document = parse(response.body);
    List<Element> days = document.getElementsByClassName('step-content');
    Day today = getTodayDay(days);
    List<Day> daysR = [];
   // today.Prints();
    daysR.add(today);
    days.remove(days[0]);
    var visualiser = Visualizer();
    for (var day in days) {
      List<Subject> subjectsR = [];
      List<Element> subjects = day.getElementsByClassName(subjectClassHtml);
      subjects.remove(subjects[0]);
      for (var subject in subjects) {
        subjectsR.add(visualiser.subjectFromHTML(subject));
      }
      String date = visualiser.formatNewLines(day.getElementsByTagName('span')[0].text);
      var d = Day(date: date, subjects: subjectsR, type: 'usual');
      daysR.add(d);
    }
    return daysR;
  } else {
    throw Exception();
  }
}

Future<List<Day>> getListOfDaysSelectedWeek(Future<Week> weekFuture) async {
  Week week = await weekFuture;
  String groupUrlWithWeek = 'https://mai.ru/education/studies/schedule/index.php?group=М3О-223Б-21&week='+week.number;
  final response =
  await http.Client().get(Uri.parse(groupUrlWithWeek));
  if (response.statusCode == 200) {
    var document = parse(response.body);
    List<Element> days = document.getElementsByClassName('step-content');
    Day today = getTodayDay(days);
    List<Day> daysR = [];
   // today.Prints();
    daysR.add(today);
    days.remove(days[0]);
    var visualiser = Visualizer();
    for (var day in days) {
      List<Subject> subjectsR = [];
      List<Element> subjects = day.getElementsByClassName(subjectClassHtml);
      subjects.remove(subjects[0]);
      for (var subject in subjects) {
        subjectsR.add(visualiser.subjectFromHTML(subject));
      }
      String date = visualiser.formatNewLines(day.getElementsByTagName('span')[0].text);
      var d = Day(date: date, subjects: subjectsR, type: 'usual');
      daysR.add(d);
    }
    return daysR;
  } else {
    throw Exception();
  }
}

Future<List<Day>> getListOfDaysByWeek(Week week) async {
  final response =
  await http.Client().get(Uri.parse(groupUrl));
  if (response.statusCode == 200) {
    var document = parse(response.body);
    List<Element> days = document.getElementsByClassName('step-content');
    Day today = getTodayDay(days);
    List<Day> daysR = [];
   // today.Prints();
    daysR.add(today);
    days.remove(days[0]);
    var visualiser = Visualizer();
    for (var day in days) {
      List<Subject> subjectsR = [];
      List<Element> subjects = day.getElementsByClassName(subjectClassHtml);
      subjects.remove(subjects[0]);
      for (var subject in subjects) {
        subjectsR.add(visualiser.subjectFromHTML(subject));
      }
      String date = visualiser.formatNewLines(day.getElementsByTagName('span')[0].text);
      var d = Day(date: date, subjects: subjectsR, type: 'usual');
      daysR.add(d);
    }
    return daysR;
  } else {
    throw Exception();
  }
}

List<Department> getDepartments()  {
  List<Department> departments = [
    Department(number: '1', name: 'Институт №1'),
  Department(number: '2', name: 'Институт №2'),
  Department(number: '3', name: 'Институт №3'),
  Department(number: '4', name: 'Институт №4'),
  Department(number: '5', name: 'Институт №5'),
  Department(number: '6', name: 'Институт №6'),
  Department(number: '7', name: 'Институт №7'),
  Department(number: '8', name: 'Институт №8'),
  Department(number: '9', name: 'Институт №9'),
  Department(number: '10', name: 'Институт №10'),
  Department(number: '11', name: 'Институт №11'),
  Department(number: '12', name: 'Институт №12'),
  ];
  return departments;
}

List<String> getCourses()  {
  List<String> courses = [
    '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  ];
  return courses;
}
