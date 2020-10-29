import 'package:firebase_database/firebase_database.dart';
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

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = "Alan";
  var database = FirebaseDatabase.instance;
  Task lastDeleted;
  int lastDeletedIndex;
  List<Task> toDoList = [
  ];

  void LoadFromDataBase(){
    Map taskMap;
    database.reference().once().then((DataSnapshot currentData){
      taskMap = currentData.value[user];
      taskMap.forEach((title, data) {
        toDoList.add(Task(data['title'],data['description'],isDone: data['isDone'], isShowingDescription: data['isShowingDescription']));
    });
    });
  }
  @override
  void initState() {
    super.initState();
    LoadFromDataBase();
    database.setPersistenceEnabled(true);
  }
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
                              database.reference().child(user).child(lastDeleted.title).set(lastDeleted.getMap());
                              lastDeleted = null;
                              lastDeletedIndex = null;
                            });
                          },
                        ),
                      ));
                      lastDeleted = toDoList[index];
                      lastDeletedIndex = index;
                      toDoList.removeAt(index);
                      database.reference().child(user).child(lastDeleted.title).remove();
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
              database.reference().once().then((DataSnapshot snapshot) {
                print('Data : ${snapshot.value}');
              });
              Task newTask = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateTaskScreen()),
              );
              setState(() {
                print(toDoList);
                if (newTask != null)
                  {
                    toDoList.add(newTask);
                    database.reference().child(user).child(newTask.title).set(newTask.getMap());
                    }
              });
            })

    );
  }
}
