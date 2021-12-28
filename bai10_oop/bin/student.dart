enum Gender {
  male,
  female,
}

class Student {
  late String name;
  late String major;
  late String _email;

  Student.male() {
    name = "cuong";
  }

  Student.female() {
    name = "mai";
  }

  // factory (nhà máy) để return ra ctor khác nhau "của" class đó
  factory Student(Gender gender) {
    if (gender == Gender.male) {
      return Student.male();
    } else {
      return Student.female();
    }
  }

  set email(String email) => _email = email;
  String get email => _email;

  void showInfo() {
    print(name);
    print(major);
    print(email);
  }

  void _showPrivate() {
    print(email);
  }
}
