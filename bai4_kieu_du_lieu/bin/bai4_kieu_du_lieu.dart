void main(List<String> arguments) {
  int a = 1;
  double b = 1.23;
  String c = "string c";
  String d = 'string d';

  bool e = false;

  print(a);
  print(b);

  // string interpolation
  String firstName = "Cuong";
  String lastName = "Pham";

  String fullName = "$firstName $lastName";
  print(fullName);

  dynamic number = 1.23;
  print(number.runtimeType);

  number = "1.23";
  print(number.runtimeType);

  var u = "\u{04C4}";
  print(u);

  Runes input = Runes("\u{2665} \u{1f605} \u{1f47b}");

  print(String.fromCharCodes(input));

  // const, final: Khi đã gán giá trị thì không thể thay đổi
  var PI = 3.14;
  // const double PI1 = PI; // Error - vì const phải được xác định khi build
  // mà biến PI ở trên chỉ được gán giá trị 3.14 khi chương trình được chạy

  const double PI1 = 3.14; // dart sẽ tối ưu và đưa PI1 vào binary

  final PI2 = PI; // OK - vì final có thể được gán giá trị ở runtime
}
