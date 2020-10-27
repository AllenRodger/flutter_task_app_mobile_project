import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:todo_list/create_task_screen.dart';
import 'package:todo_list/watermark.dart';
import "package:http/http.dart" as http;
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
  final String Identificador = 'Alan';
  final String url = "https://to-do-list-allen.firebaseio.com/";
  Task lastDeleted;
  int lastDeletedIndex;
  List<Task> toDoList = [
  ];
  void loadListFromDataBase() async {
    final response = await http.get(url+Identificador);
    var listElements = json.decode(response.body);
    setState(() {
      listElements.forEach((key,value){
        toDoList.add(Task(value['title'],value['description'],isDone: value['isDone'], isShowingDescription: value['isShowingDescription'],id: key));
      });
    });
  }
  @override
  void initState() {
    super.initState();
    loadListFromDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: FlatButton(child: Icon(Icons.cloud_upload,color: Colors.green),onPressed: (){
            if (toDoList.isNotEmpty == true)
              {
                toDoList.forEach((task){
                  http.post(url+Identificador+".json",body: json.encode(task.getMap()));
                });
              }
          },),
          backgroundColor: Colors.lightGreenAccent,
          title: Text("Lista de Tarefas",style: TextStyle(color: Colors.green),),
          centerTitle: true,
        ),
        body: Container(
            child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index){
                return Dismissible(
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    child: Row(
                      children: <Widget>[
                        Container(width: 15,),
                        Icon(Icons.delete)
                      ],
                    ),
                    color: Colors.red,),
                key: UniqueKey(),
                onDismissed: (direction){
                  if(direction == DismissDirection.startToEnd){
                    setState(() {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 5),
                        content: Text('Tarefa deletada!'),
                        action: SnackBarAction(
                          label: 'Desfazer',
                          onPressed: () {
                            setState(() {
                              toDoList.insert(lastDeletedIndex, lastDeleted);
                              lastDeleted = null;
                              lastDeletedIndex = null;
                            });
                          },
                        ),
                      ));
                          http.delete(url+Identificador+".json");
                      lastDeleted = toDoList[index];
                      lastDeletedIndex = index;
                      toDoList.removeAt(index);
                    });
                  };
    },
                child: ListRender(toDoList[index]),);
              }

    )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreenAccent,
        child: Icon(Icons.add,color: Colors.green,),
            onPressed: () async {
              Task newTask = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateTaskScreen()),
              );
              setState(() {
                print(toDoList);
                if (newTask != null)
                  {
                    toDoList.add(newTask);
                    }
              });
            })

    );
  }
}
