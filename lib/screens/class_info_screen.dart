import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:grades_cracker/models/student_class.dart';
import 'package:grades_cracker/widgets/grade_container_widget.dart';
import 'package:hive/hive.dart';

class ClassInfoScreen extends StatefulWidget{

  ClassInfoScreen({super.key, required this.studentClass});
  final StudentClass studentClass;

  @override
  State<ClassInfoScreen> createState() {
    return _ClassInfoScreenState();
  }
}

class _ClassInfoScreenState extends State<ClassInfoScreen> {

  late var ds = widget.studentClass.grades;
  late var gradeTypes = widget.studentClass.gradesType;
  List<String> list = <String>['HOMEWORK', 'TEST', 'QUIZ', 'OTHER'];
  late var selectedValue = list.first;
  TextEditingController gradescont = TextEditingController();
  var grade = "";


  void hello(int ii) {
    setState(() {
      ds.removeAt(ii);
      gradeTypes.removeAt(ii);
      gradeTypes = widget.studentClass.gradesType;
      ds = widget.studentClass.grades;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.studentClass.className}"),
        actions: [
          IconButton(onPressed: (){
            GoRouter.of(context).go("/classes");
          },icon: Icon(Icons.arrow_back)),
        ],
      ),
      body: SafeArea(
        child: Padding(padding: EdgeInsetsGeometry.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DropdownButton(value: selectedValue,items:list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(), onChanged: (iitem){
                      setState(() {
                        selectedValue = iitem.toString();
                      });
                    }),

                    Flexible(
                      child: TextField(keyboardType: TextInputType.number,decoration: InputDecoration(
                        labelText: "Grade",
                      ),controller: gradescont,),
                    )
                  ],
                ),
              ),
              TextButton(onPressed: (){
                print(selectedValue.toString());
                setState(() {
                  widget.studentClass.gradesType.add(selectedValue.toString());
                  widget.studentClass.grades.add(int.parse(gradescont.text));
                  widget.studentClass.save();
                  gradeTypes = widget.studentClass.gradesType;
                  ds = widget.studentClass.grades;
                  gradescont.clear();
                });
              }, child: Text("Add grade")),
              Flexible(
                child:ListView.builder(itemCount:ds.length,itemBuilder: (ctx,inds) {
                  return Container(
                    width: double.infinity,
                    child: GradeContainerWidget(hello,grade: ds.elementAt(inds),ins: inds,gradetype:gradeTypes.elementAt(inds)),
                  );
                }),
              )
            ],
          ),
        ),
      )
    );
  }

}