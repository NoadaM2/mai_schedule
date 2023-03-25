import '../domain/subject.dart';

class Day {
  final String date;
  String type;
  final List<Subject> subjects;
  int lk_count = 0;
  int pz_count = 0;
  int lr_count = 0;
  int ekz_count = 0;

  bool isToday(){
    if (type == "today") {
      return true;
    }
    return false;
  }

  changeType(String s){
    type = s;
  }

  Day({
    required this.date,
    required this.subjects,
    required this.type,
  });

   Prints(){
    print('\n');
    print('!!!!!!!!!!!!!DAY!!!!!!!!!!!!!');
    print(date);
    print(type);
    for (var s in subjects) {
      s.Prints();
    }

    print('-------------DAY-------------');
  }

  CountIndexes() {
    lk_count = 0;
    pz_count = 0;
    lr_count = 0;
    ekz_count = 0;
    for (var subject in subjects) {
      switch(subject.type){
        case "ЛК":
          lk_count += 1;
          break;
        case "ПЗ":
          pz_count += 1;
          break;
        case "ЛР":
          lr_count += 1;
          break;
        case "ЭКЗ":
          ekz_count += 1;
          break;
      }
    }
  }
}