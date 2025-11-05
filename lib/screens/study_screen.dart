import 'dart:convert';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudyScreen extends StatefulWidget{
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() {
    return _StudyScreenState();
  }

}

class _StudyScreenState extends State<StudyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Study Time",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                  Spacer(),
                  IconButton(onPressed: () {
                    GoRouter.of(context).go("/");
                  }, icon: Icon(Icons.arrow_back))
                ]
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "What do you want to study today?"
                )
              ),
              SizedBox(height: 3),
              Container(
                width: double.infinity,
                child: ElevatedButton(onPressed: () async{

                  final jsonSchema = Schema.object(
                    properties: {
                      'questions': Schema.array(
                        items: Schema.object(
                          properties: {
                            'study_question': Schema.string(description: "question about the topic that was given"),
                            'correct_answer': Schema.string(description: "correct answer from the question given"),
                            'options': Schema.array(
                              items: Schema.string(description: "possible answers"),
                            ),
                            'explanation': Schema.string(description:"short description of the answer"),
                          },
                        ),
                      ),
                    },
                  );

                  final model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash',generationConfig: GenerationConfig(
                      responseMimeType: 'application/json',
                      responseSchema: jsonSchema
                  ));

                  var studyTopic = "5 study questions about the topic of pythagorean theorem";
                  final response = await model.generateContent([Content.text(studyTopic)]);
                  GoRouter.of(context).go("/study/questions",extra: response.text!);
                  // Map<String,dynamic> data = jsonDecode(response.text!);
                  // List<Map<String,dynamic>> questions = data["questions"].cast<Map<String,dynamic>>();
                  // List<String> options = questions[0]["options"].cast<String>();
                  // options.shuffle();
                  // print(options);
                  // print(response.text);
                }, child: Text("Study")),
              )
            ]
          ),
        ),
      ),
    );
  }

}
