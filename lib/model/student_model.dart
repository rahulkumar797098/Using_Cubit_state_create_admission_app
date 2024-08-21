class StudentModel {
  final int? id;
  final String name;
  final String father;
  final String age;
  final String classNam;

  StudentModel({
    this.id,
    required this.name,
    required this.father,
    required this.age,
    required this.classNam,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'father': father,
      'age': age,
      'class_nam': classNam,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'],
      name: map['name'],
      father: map['father'],
      age: map['age'],
      classNam: map['class_nam'],
    );
  }
}
