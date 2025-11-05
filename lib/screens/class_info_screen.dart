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

  double calculateWeightedTest(){
    double result = 0.0;
    double test= 0;
    for(int  i = 0; i < gradeTypes.length; i++ ){
      if(gradeTypes.elementAt(i) == "TEST"){
        test++;
        result+= ds.elementAt(i);
      }
    }
    if(test == 0){
      return 0;
    }
    result = result/test;
    return result;
  }

  double calculateWeightedQuizes() {
    double result = 0.0;
    double test = 0;
    for (int i = 0; i < gradeTypes.length; i++) {
      if (gradeTypes.elementAt(i) == "QUIZ") {
        test++;
        result += ds.elementAt(i);
      }
    }
    if (test == 0) {
      return 0;
    }
    result = (result / test) * (double.parse(widget.studentClass.quizPercent.toString()) /100);
    print((double.parse(widget.studentClass.quizPercent.toString()) /100));
    return result;
  }

  double calculateWeightedHomeworks(){
    double result = 0.0;
    double test= 0;
    for(int  i = 0; i < gradeTypes.length; i++ ){
      if(gradeTypes.elementAt(i) == "HOMEWORK"){
        test++;
        result+= ds.elementAt(i);
      }
    }
    if(test == 0){
      return 0;
    }
    result = result/test;
    return result;
  }

  double calculateWeightedOthers(){
    double result = 0.0;
    double test= 0;
    for(int  i = 0; i < gradeTypes.length; i++ ){
      if(gradeTypes.elementAt(i) == "OTHER"){
        test++;
        result+= ds.elementAt(i);
      }
    }
    if(test == 0){
      return 0;
    }
    result = result/test;
    return result;
  }


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
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsetsGeometry.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2),

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

                  try{

                    double grade = double.parse(gradescont.text);

                    setState(() {
                      widget.studentClass.gradesType.add(selectedValue.toString());
                      widget.studentClass.grades.add(grade);
                      widget.studentClass.save();
                      gradeTypes = widget.studentClass.gradesType;
                      ds = widget.studentClass.grades;
                      gradescont.clear();
                    });
                  }catch (e){
                    gradescont.clear();
                  }

                }, child: Text("Add grade")),
                SizedBox(height: 2),
                SizedBox(
                  height: 500,
                  child: ListView.builder(itemCount:ds.length,itemBuilder: (ctx,inds) {
                      return Container(
                        width: double.infinity,
                        child: GradeContainerWidget(hello,grade: ds.elementAt(inds),ins: inds,gradetype:gradeTypes.elementAt(inds)),
                      );
                    })
                ),

                Text("Summary"),
                Text("TEST AVERAGE: ${calculateWeightedTest()}"),
                Text("QUIZ AVERAGE: ${calculateWeightedQuizes()}"),
                Text("HOMEWORK AVERAGE: ${calculateWeightedHomeworks()}"),
                Text("OTHER AVERAGE: ${calculateWeightedOthers()}"),

              ],
            ),
          ),
        )
        ),
      );
  }

}