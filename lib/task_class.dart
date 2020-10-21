

class Task {
  final String title;
  final String description;
  bool isDone;
  bool isShowingDescription;

  Task(
    this.title,
    this.description,
   {this.isShowingDescription = false,
     this.isDone = false}
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
}