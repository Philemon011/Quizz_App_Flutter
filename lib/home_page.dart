import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizz/quizz_page.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final height=size.height;
    final width=size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple ,
        title: Text(
            "Quizz Flutter",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: Center(
        child: Card(
          color: Colors.deepPurple.shade100,
          elevation: 9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: EdgeInsets.all(8),
                  child: Image.asset(
                    "images/cover.jpg",
                    height: height/2,
                    width: width* 0.8,
                    fit: BoxFit.cover,
                  )
              ),

              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx){
                      return QuizzPage();
                    }));
                  },
                  child: Text("Commencer le Quizz")
              )
            ],
          ),
        ),
      ),
    );
  }
}