import 'package:flutter/material.dart';
import 'package:quizz/datas.dart';
import 'package:quizz/question.dart';
import 'package:quizz/text_with_style.dart';

class QuizzPage extends StatefulWidget{
  @override
  QuizzPageState createState() => QuizzPageState();
}

class QuizzPageState extends State <QuizzPage>{
  List<Question> questions= Datas().listeQuestions;
  int index=0;
  int score=0;
  @override
  Widget build(BuildContext context) {
    final Question question=questions[index];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple ,
        title: Text(
          "Score: $score",
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(8),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWithStyle(data:'Question numéro: ${index+1}/ ${questions.length}', color: Colors.deepPurple,style: FontStyle.italic,),
                TextWithStyle(data: question.question,size: 21,),
                Image.asset(question.getImage()),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    answerBtn(false),
                    answerBtn(true)
                  ],
                )
              ],
            ),
          ),

        ),
      ),
    );
  }
  ElevatedButton answerBtn(bool b) {
    return ElevatedButton(
      onPressed: () {
        checkAnswer(b);
      },
      child: Text((b) ? "VRAI" : "FAUX"),
      style: ElevatedButton.styleFrom(primary: (b) ? Colors.greenAccent : Colors.redAccent),

    );
  }

  checkAnswer(bool answer){
    final question= questions[index];
    bool bonneReponse=(question.reponse==answer);

    if(bonneReponse){
      setState(() {
        score++;
      });
    }
    showAnswer(bonneReponse);

  }

  Future<void> showAnswer(bool bonneReponse)async{
    Question question=questions[index];
    String title=(bonneReponse) ? "C'est gagné" : "Perdu";
    String imageToShow=(bonneReponse) ? "vrai.jpg" : "faux.jpg";
    String path= "images/$imageToShow";
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            title: TextWithStyle(data: title),
            children: [
              Image.asset(path),
              TextWithStyle(data: question.explication),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    toNextQuestion();
                  },
                  child: TextWithStyle(data: "Passer à la question suivante")
              )
            ],
          );
        }
    );
  }

  Future<void> showResult() async {
    return await showDialog(
        barrierDismissible:  false,
        context: context,
        builder: (BuildContext ctx){
          return AlertDialog(
              title: TextWithStyle(data:"C'est fini"),
              content: TextWithStyle(data: "Votre score est de :$score points",),
              actions: [
              TextButton(
              onPressed: (){
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
          },
          child: TextWithStyle(data: "Ok"))
          ],
          );
        }
    );
  }
  void toNextQuestion(){
    if (index<questions.length-1){
      index++;
      setState(() {
      });
    }else{
        showResult();
    }


  }
}