import 'package:flutter/material.dart';
import 'package:todo_list/task_class.dart';

class CreateTaskScreen extends StatelessWidget {
   TextEditingController title = new TextEditingController();
   TextEditingController description = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text('Crie uma nova tarefa!',style: TextStyle(color: Colors.green),)),
      body: Column(
        children: <Widget>[
        TextField(
          controller: title,
          decoration: InputDecoration(hintText: "Nome da tarefa"),),
        TextField(
          controller: description,
          decoration: InputDecoration(hintText: "Descrição da tarefa")),
          RaisedButton(onPressed: (){
            if(title == null && description == null || title == null ||title.text.isEmpty) {
            }
            else{
              Navigator.pop(context,Task(title.text,description.text));
            }
          },)
    ],
    ),
    );
  }


}
