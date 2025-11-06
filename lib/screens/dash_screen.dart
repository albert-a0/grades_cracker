import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashScreen  extends StatefulWidget {
  DashScreen({super.key});

  @override
  State<DashScreen> createState() {
    return _DashScreenState();
  }

}

class _DashScreenState extends State<DashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PopScope(
        canPop: false,
        child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(padding: EdgeInsetsGeometry.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome Back",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600)),
                    SizedBox(height: 14),
                    Container(
                      decoration: BoxDecoration(color: Color.fromRGBO(84, 94, 117,1),borderRadius: BorderRadius.all(Radius.circular(25))),
                      width: double.infinity,
                      height: 120,
                      child: TextButton(

                          onPressed: (){
                            GoRouter.of(context).go("/aiassistant");
                          },
                          child: Text("AI Tutor",style: TextStyle(fontSize: 18,color: Colors.white), )),
                    ),
                    SizedBox(height: 14),
                    Container(
                      decoration: BoxDecoration(color: Color.fromRGBO(236, 210, 166,1),borderRadius: BorderRadius.all(Radius.circular(25))),
                      width: double.infinity,
                      height: 120,
                      child: TextButton(
                          onPressed: (){
                            GoRouter.of(context).go("/classes");
                          },
                          child: Text("Classes",style: TextStyle(fontSize: 18,color: Colors.white), )),
                    )
                    // Container(
                    //   decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.all(Radius.circular(25))),
                    //   width: double.infinity,
                    //   height: 120,
                    //   child: TextButton(
                    //
                    //       onPressed: (){
                    //         GoRouter.of(context).go("/study");
                    //       },
                    //       child: Text("Study",style: TextStyle(fontSize: 18,color: Colors.white), )),
                    // ),

                  ],
                ),
              ),
            )
        ),
      )
    );
  }

}