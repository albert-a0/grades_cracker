import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuestionsScreen extends StatefulWidget {
  QuestionsScreen(this.questions,{super.key});
  final String questions;


  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }

}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int questionIndex = 0;
  var currentQ = "";
  var currentCorrect = "";
  late Map<String,dynamic> data = jsonDecode(widget.questions);
  late Iterable<Map<String,dynamic>> questions = data["questions"].cast<Map<String,dynamic>>();

  Iterable<String> options =  Iterable.empty();
  List<String> userAnswers =  [];






  @override
  void initState() {
    super.initState();
    //currentQ = questions[questionIndex]["study_question"];
    currentQ = questions.elementAt(questionIndex)["study_question"];
    //currentCorrect = questions[questionIndex]["correct_answer"];
    currentCorrect = questions.elementAt(questionIndex)["correct_answer"];
    List<String> d = questions.elementAt(questionIndex)["options"].cast<String>();
    d.shuffle();
    options =d as Iterable<String>;

  }

  void addUserAnswer(String s) {
    userAnswers.add(s);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Padding(padding: EdgeInsetsGeometry.all(30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(currentQ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                SizedBox(height: 3),
                ...options.map((String el) {
                  return Container(
                    width: double.infinity,
                    child: Padding(padding: EdgeInsetsGeometry.all(5),
                      child: ElevatedButton(onPressed: (){

                        setState(() {
                          if(questionIndex != 4){
                            questionIndex++;
                            currentQ = questions.elementAt(questionIndex)["study_question"];
                            currentCorrect = questions.elementAt(questionIndex)["correct_answer"];
                          }else{
                            GoRouter.of(context).go("/");
                          }

                        });
                        addUserAnswer(el);
                      }, child: Text(el)),
                    )
                  );
                }).toList(),

              ],
            ),
          ),
        )
      ),
    );
  }

}