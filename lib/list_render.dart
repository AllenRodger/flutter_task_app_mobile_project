import 'package:flutter/material.dart';
import 'task_class.dart';
class ListRender extends StatefulWidget {

  final Task task;
  ListRender(this.task);
  @override
  _ListRenderState createState() => _ListRenderState();
}

class _ListRenderState extends State<ListRender> {



  IconData ArrowIcon() {
    if (widget.task.isShowingDescription == true){
      return Icons.arrow_drop_down;
    }else{
      return Icons.arrow_right;
    }

  }
  String ShowDescriptionPreview(tr) {
    return "";
  }
  String ShowFullDescription(tr){
      if (tr.description != ""){
        return tr.description;
      }else{
        return "Sem descrição!!";
      };
  }
  String ShowDescription(task){
    if (task.isShowingDescription == true)
      {
        return ShowFullDescription(task);
      }
    else
      {
        return ShowDescriptionPreview(task);
      }
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        value: widget.task.isDone,
        activeColor: Colors.green,
        title: Text(widget.task.title,style: TextStyle(fontSize: 20),),
        subtitle: Text(ShowDescription(widget.task),style: TextStyle(fontSize: 15)),
        secondary: SizedBox(
          width: 50,
          height: 50,
          child: Stack(
            children: <Widget>[
              Icon(ArrowIcon(),size: 40,),
              GestureDetector(
                onTap: (){
                  setState(() {
                    widget.task.changeShowingDescription();
                  });
                },
              )
            ],
          )),
        onChanged: (context) {
          setState(() {
            widget.task.changeValue();
            return widget.task.isDone;
          });
        }
    );
  }


}
