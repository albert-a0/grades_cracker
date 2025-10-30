
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
  var startTime = "";
  var endTime = "";

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
              TextField(decoration: InputDecoration(labelText: "Enter class name"),
              controller: className,),
              SizedBox(height: 15),

              TextButton(onPressed: (){
                final box = Hive.box("appbox3");
                StudentClass newClass = StudentClass();
                newClass.className = className.text;
                box.add(newClass);
                GoRouter.of(context).go("/classes");
              }, child: Text("ADD IT"))
            ],
          ),
        ),
      ),
    );
  }

}