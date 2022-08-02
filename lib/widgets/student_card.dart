import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:interviewapp/models/student.dart';
import 'package:interviewapp/theme.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  StudentCard(this.student);

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      width: 200,
      height: 150,
      child:
      Column(
            children: [
              Text(
                'Nama : ${student.name}',
                style: blackTextStyle.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                'Nilai : ${student.nilai}',
                style: blackTextStyle.copyWith(fontSize: 18),
              ),
              Text(
                'Waktu : ${student.waktu}',
                style: blackTextStyle.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          )
    );
  }
}
