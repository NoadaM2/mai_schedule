import '../domain/subject.dart';

class Day {
  final String date;
  final String type;
  final List<Subject> subjects;


  Day({
    required this.date,
    required this.subjects,
    required this.type,
  });

  void Prints(){
    print('\n');
    print('!!!!!!!!!!!!!DAY!!!!!!!!!!!!!');
    print(date);
    print(type);
    for (var s in subjects) {
      s.Prints();
    }
    print('-------------DAY-------------');

  }
}