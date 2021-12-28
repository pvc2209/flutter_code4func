import 'student.dart';

void main(List<String> arguments) {
  Student student = Student.male();
  student.name = "PVC";
  student.major = "SE";
  student.email = "cuong@gmail.com";

  // print(student.email);

  student.showInfo();
}
