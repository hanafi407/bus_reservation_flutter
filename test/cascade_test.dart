import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';

class Person {
  String name;
  int age;

  Person({required this.name, required this.age});

  String setName(String name) {
    return this.name = name;
  }

  int setAge(int age) {
    return this.age = age;
  }
}

void main() {
  Logger logger = Logger();
  test("Cascade operator", () {
    Person person = Person(name: "hanafi", age: 30);

    person
      ..setName("herlambang")
      ..setAge(40);

    logger.i("Name: ${person.name}, age: ${person.age}");
  });
}
