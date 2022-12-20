import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import '../../domain/day.dart';
import '../../domain/subject.dart';
import '../../data/converter/visualizer.dart';

String groupUrl = 'https://mai.ru/education/studies/schedule/index.php?group=М3О-209Б-21';
String groupUrl1 = 'https://mai.ru/education/studies/schedule/index.php?group=М3О-223Б-21&week=10';

String dateClassHtml = 'step-title ms-3 ms-sm-0 mt-2 mb-4 mb-sm-2 py-1 text-body';
String todayDateClassHtml = "step-title ms-3 ms-sm-0 mt-2 mb-4 mb-sm-2 py-1 text-primary";

String subjectClassHtml = "mb-4";
String subjectNameClassHtml = "d-flex align-items-center justify-content-between";
String subjectInfoClassHtml = "list-inline list-separator text-body small";
String subjectTypeClassHtml = 'badge bg-soft-secondary text-secondary ms-2 fw-medium text-smaller';

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



Future<List<Day>> getTodaysWeek() async {
  final response =
  await http.Client().get(Uri.parse(groupUrl));
  if (response.statusCode == 200) {
    var document = parse(response.body);
    List<Element> days = document.getElementsByClassName('step-content');
    Day today = getTodayDay(days);
    List<Day> daysR = [];
    today.Prints();
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
