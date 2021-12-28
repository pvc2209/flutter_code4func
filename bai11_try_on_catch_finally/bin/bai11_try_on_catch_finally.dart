void main(List<String> arguments) {
  parseInt("abc");

  try {
    sendEmail();
  } catch (e) {
    print(e);
  }
}

void sendEmail() {
  throw Exception("Chua implement");
}

int parseInt(String value) {
  try {
    var a = 10;
    var b = 0;

    var c = a ~/ b;

    print(c);

    return int.parse(value);
  } on FormatException {
    print("Loi 1");
  } on IntegerDivisionByZeroException catch (e) {
    print("Loi 2 " + e.toString());
  } catch (e) {
    print("Loi chua biet");
  } finally {
    print("Kieu gi cung chay vao");
  }

  return -1;
}
