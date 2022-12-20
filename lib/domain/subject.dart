

class Subject {
  final String name;
  final String type;
  final String time;
  final String teacher;
  final String place;


  Subject({
    required this.name,
    required this.type,
    required this.time,
    required this.teacher,
    required this.place,
  });

    void Prints(){
    print('*************SUBJECT*************');
    print(name);
    print(type);
    print(time);
    print(teacher);
    print(place);
    print('-------------SUBJECT-------------');

  }

}