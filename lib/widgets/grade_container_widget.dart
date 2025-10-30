import 'package:flutter/material.dart';

class GradeContainerWidget extends StatelessWidget{
  GradeContainerWidget(this.pressed,{super.key, required this.grade,required this.ins,this.gradetype});
  final int grade;
  final int ins;
  void Function(int ii) pressed;
  final String? gradetype;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: (grade<= 65)?Colors.redAccent:((grade>=66 && grade <=79)?Colors.yellow:Colors.green),
      child: Padding(padding: EdgeInsetsGeometry.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(gradetype.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
            Text(grade.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
            TextButton(onPressed: (){
              pressed(ins);
            }, child: Text("DELETE"))
          ],
        ),
      ),
    );
  }

}