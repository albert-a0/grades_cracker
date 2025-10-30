import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppAssistant extends StatefulWidget{
  AppAssistant({super.key});

  @override
  State<AppAssistant> createState() {
    return _AppAssistantState();
  }

}

class _AppAssistantState extends State<AppAssistant> {
  String resultAnswer = "";
  TextEditingController studentQuestionCont = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    studentQuestionCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: EdgeInsetsGeometry.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("AI Tutor",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                  Spacer(),
                  IconButton(onPressed:(){
                    GoRouter.of(context).go("/");
                  }, icon: Icon(Icons.arrow_back))
                ],
              ),
              TextField(
                decoration: InputDecoration(labelText: "Ask me"),
                controller: studentQuestionCont,
              ),
              TextButton(onPressed: () async{
                final model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');
                // Provide a prompt that conains text
                final prompt = [Content.text((studentQuestionCont.text.isEmpty)? "give me a funny joke":studentQuestionCont.text)];
                // To generate text output, call generateContent with the text input
                final response = await model.generateContent(prompt);
                setState(() {
                  resultAnswer = response.text!;
                });
              }, child: Text("ASK AWAY")),
              SizedBox(height: 20),
              Expanded(
                child:  SizedBox(
                  child: SingleChildScrollView(
                    child: Text((resultAnswer.length ==0)?"Here is the answer":resultAnswer),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }


}