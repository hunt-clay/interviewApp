import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:interviewapp/models/student.dart';

class StudentProvider extends ChangeNotifier {
  getStudent() async {
    var result = await http
        .get(Uri.parse('https://interview-api1.herokuapp.com/interviews'));

    // print(result.statusCode);
    // print(result.body);

    if (result.statusCode == 200) {
      List data = jsonDecode(result.body);
      List<Student> students =
          data.map((item) => Student.fromJson(item)).toList();
      return students;
    } else {
      return <Student>[];
    }
  }
}
