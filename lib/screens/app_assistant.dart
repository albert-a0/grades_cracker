import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';

class AppAssistant extends StatefulWidget{
  @override
  State<AppAssistant> createState() {
    return _AppAssistantState();
  }

}

class _AppAssistantState extends State<AppAssistant> {
  String resultAnswer = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: EdgeInsetsGeometry.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Ask me"),
              ),
              TextButton(onPressed: () async{
                final model =
                FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');

                // Provide a prompt that contains text
                final prompt = [Content.text('Write a story about a magic backpack.')];

                // To generate text output, call generateContent with the text input
                final response = await model.generateContent(prompt);
                setState(() {
                  resultAnswer = response.text!;
                });
              }, child: Text("ASK AWAY")),
              SizedBox(height: 20),
              SizedBox(
                height: 500,
                child: SingleChildScrollView(
                  child: Text((resultAnswer.length ==0)?"Here is the answer":resultAnswer),
                ),
              )
            ],
          )
        ),
      ),
    );
  }


}