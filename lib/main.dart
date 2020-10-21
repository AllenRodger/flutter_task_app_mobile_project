import 'package:flutter/material.dart';
import 'package:todo_list/create_task_screen.dart';
import 'package:todo_list/watermark.dart';

import 'list_render.dart';
import 'task_class.dart';

void main()=> runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomePage(),));



class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Task> toDoList = [
    Task('Exemplo de Tarefa!', 'Esse é um exemplo de tarefa.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          title: Text("Lista de Tarefas",style: TextStyle(color: Colors.green),),
          centerTitle: true,
        ),
        body: Container(
            child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index){
              return ListRender(toDoList[index]);
                },                                                                                                                                                                                                                                                                                        6
            )

        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreenAccent,
        child: Icon(Icons.add,color: Colors.green,),
            onPressed: () async {
              Task newTask = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateTaskScreen()),
              );
              setState(() {
                if (newTask != null)
                  {
                    print(newTask);
                    toDoList.add(newTask);}
              });
            })
    );
  }
}
