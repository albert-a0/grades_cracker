
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grades_cracker/models/student_class.dart';
import 'package:hive/hive.dart';

class ClassAddScreen extends StatefulWidget {
  ClassAddScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClassAddScreenState();
  }

}


class _ClassAddScreenState extends State<ClassAddScreen> {

  TextEditingController className = TextEditingController();
  TextEditingController classTeacher = TextEditingController();
  TextEditingController classCredit = TextEditingController();
  TextEditingController classTest = TextEditingController();
  TextEditingController classHomework = TextEditingController();
  TextEditingController classQuiz = TextEditingController();
  TextEditingController classOther = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    className.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsetsGeometry.all(10),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
                Row(
                  children: [
                    Text("Add a class",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                    Spacer(),
                    IconButton(onPressed: () {
                      GoRouter.of(context).go("/classes");
                    }, icon: Icon(Icons.arrow_back))
                  ],
                ),
                SizedBox(height: 5),

                Text("General",style:  TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                TextField(decoration: InputDecoration(labelText: "Enter class name"),controller: className,),
                SizedBox(height: 5),
                TextField(decoration: InputDecoration(labelText: "Teacher name"),controller: classTeacher,),
                SizedBox(height: 20),

                Text("Class Credit",style:  TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                TextField(decoration: InputDecoration(labelText: "Enter credit "),controller: classCredit,),
                SizedBox(height: 20),

                Text("Grade Percentage %",style:  TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                Text("make sure your inputs for this sections are correct and no need to enter percent sign"),
                TextField(decoration: InputDecoration(labelText: "Homework % "),keyboardType: TextInputType.number,controller: classHomework,),
                TextField(decoration: InputDecoration(labelText: "Test % "),keyboardType: TextInputType.number,controller: classTest,),
                TextField(decoration: InputDecoration(labelText: "Quiz % "),keyboardType: TextInputType.number,controller: classQuiz,),
                TextField(decoration: InputDecoration(labelText: "Other % "),keyboardType: TextInputType.number,controller: classOther,),

                TextButton(onPressed: (){
                  final box = Hive.box("appbox3");
                  StudentClass newClass = StudentClass();
                  newClass.className = className.text;
                  newClass.classTeacher = classTeacher.text;
                  newClass.classCredit = double.parse(classCredit.text) ;
                  newClass.homeworkPercent = double.parse(classHomework.text);
                  newClass.testPercent = double.parse(classTest.text);
                  newClass.quizPercent = double.parse(classQuiz.text);
                  newClass.otherPercent = double.parse(classOther.text);
                  box.add(newClass);
                  GoRouter.of(context).go("/classes");
                }, child: Text("ADD IT"))
              ],
            ),
          ),
        ),
      ),
    );
  }

}