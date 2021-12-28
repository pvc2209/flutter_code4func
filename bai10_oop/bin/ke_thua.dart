class Person {
  late String name;
  late int age;

  // Person() {}
}

class Woman extends Person {
  void shopping() {
    print("Go to market");
  }
}

// Để có thể dùng with với Person thì bắt buộc class Person không được có ctor
// Để rõ ràng hơn thì "nên" dùng with với class mixin (vì mixin ko có ctor)

// mixin-with như là 1 dạng đa kế thừa gần giống interface vậy
// Nhưng interface không có thuộc tính và các khai báo hàm
// Còn mixin thì có thuộc tính và cả định nghĩa cho hàm và cũng "ko có ctor"

// mixin tương tự interface là hỗ trợ đa kế thừa, nếu dùng abstract class thì
// chỉ kết thừa được 1 class abstract mà thôi
// => mixin giải quyết vấn đề đa kết thừa mà có sẵn định nghĩa hàm

// interface - class implement interface phải cài đặt các hàm
// mixin - class with mixin thì chỉ việc dùng hàm đó

// Ví dụ:
// Khả năng "bay"
// thì nếu dùng interface thì class implement Fly phải tự định nghĩa xem phải bay như nào
// còn khi dùng mixin Fly thì chỉ việc bay thôi

mixin Fly {
  late int height;
  void fly() {
    print("I can fly");
  }
}

mixin Swim {
  late int deep;
  void swim() {
    print("I can swim");
  }
}

class Man with Person, Fly {
  void showInfo() {
    print(name);
    print(age);
  }
}

abstract class Animal {
  run() {
    print("run");
  }

  eat();
}

class Cat extends Animal {
  @override
  run() {
    // TODO: implement run
    return super.run();
  }

  @override
  eat() {
    print("Eat");
  }
}

// Trong dart không có interface tường minh mà nó dùng chính từ khóa abstract

abstract class Run {
  run();
}

class Dog implements Run {
  @override
  run() {
    print("run");
  }
}
