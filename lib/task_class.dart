

class Task {
  final String id;
  final String title;
  final String description;
  bool isDone;
  bool isShowingDescription;

  Task(

    this.title,
    this.description,
   {this.isShowingDescription = false,
     this.isDone = false,
     this.id = ''}
  );
  void changeValue(){
    this.isDone = !this.isDone;

  }
  void changeShowingDescription(){
    if(this.isShowingDescription == true){
      this.isShowingDescription = false;}else{
      this.isShowingDescription = true;
    };
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