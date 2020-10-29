

import 'package:firebase_database/firebase_database.dart';
import 'internet_checker.dart';
class Task {
  final user = "Alan";
  var database = FirebaseDatabase.instance;
  final String id;
  final String title;
  final String description;
  bool offline;
  bool isDone;
  bool isShowingDescription;

  Task(

    this.title,
    this.description,
   {this.isShowingDescription = false,
     this.isDone = false,
     this.offline = false,
     this.id = ''}
  );
  void changeAnything(){
    database.reference().child(user).child(this.title).update(this.getMap());
  }
  void changeValue(){
    this.isDone = !this.isDone;
    changeAnything();
  }
  void changeShowingDescription(){
    if(this.isShowingDescription == true){
      this.isShowingDescription = false;}else{
      this.isShowingDescription = true;
    };
    changeAnything();

  }
  Map<String,dynamic> getMap(){
    Map<String,dynamic> taskAsMap = {
      'id':this.id,
    'title': this.title,
    'description': this.description,
    'isDone': this.isDone,
    'isShowingDescription': false
  };
    return taskAsMap;
  }
}