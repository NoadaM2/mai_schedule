
class Week {
  final String number;
  final String range;
  final String type;

  Week({
    required this.number,
    required this.range,
    required this.type,
  });

  void Prints(){
    print('*************WEEK*************');
    print('Номер недели: ' + number);
    print('Диапазон недели: ' + range);
    print('Тип недели: ' + type);
    print('-------------WEEK-------------');

  }

}