void main(List<String> arguments) {
  String str = "it\'s me";

  print(str);

  String s1 = "";

  if (s1.isEmpty) {}

  StringBuffer sbf = StringBuffer();

  sbf.write("1");
  sbf.write("2");
  sbf.write("3");

  print(sbf.toString());

  var multiLine = "This is"
      " abc";

  print(multiLine);

  var multiLine2 = '''
  SELECT * 
  FROM table_name
  WHERE userId = 123
  ''';

  print(multiLine2);
}
