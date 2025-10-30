import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grades_cracker/models/student_class.dart';
import 'package:hive/hive.dart';

class ClassesScreen extends StatefulWidget{
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() {
    return _ClassesScreenState();
  }
}

class _ClassesScreenState extends State<ClassesScreen> {

  final box = Hive.box("appbox3");
  late var st = box.values;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Classes",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                  Spacer(),
                  IconButton(onPressed: () {
                    GoRouter.of(context).go("/");
                  }, icon: Icon(Icons.arrow_back))
                ],
              ),
              Flexible(child: ListView.builder(itemCount: st.length,itemBuilder: (ctx,ind){
                return Card(
                  child: Padding(padding: EdgeInsetsGeometry.all(12),
                    child:Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(st.elementAt(ind).className.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              Text("GPA: 4.0")
                            ]
                        ),
                        Spacer(),
                        IconButton(onPressed: () {
                         GoRouter.of(context).go("/classes/info",extra: st.elementAt(ind));
                        }, icon: Icon(Icons.edit_outlined),),
                        IconButton(onPressed: () {
                          box.deleteAt(ind);
                          setState(() {
                            st = box.values;
                          });
                        }, icon: Icon(Icons.delete),)
                      ],
                    )
                  ),
                );
              })
              ),

            ],

          )
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        GoRouter.of(context).go("/classes/add");
      },child: Icon(Icons.add,color: Colors.white,fontWeight: FontWeight.w800,),backgroundColor: Colors.blueAccent,)
    );
  }
}
