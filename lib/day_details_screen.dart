import 'package:flutter/material.dart';

import 'calendar.dart';

class DayDetailsScreen extends StatelessWidget {
  final CalendarModel calendarModel;

  const DayDetailsScreen(this.calendarModel);

  @override
  Widget build(BuildContext context) {
    String imeDana;

    switch (calendarModel.odabraniDan) {
      case Dan.pon:
        imeDana = "PON";
        break;
      case Dan.uto:
        imeDana = "UTO";
        break;
      case Dan.sri:
        imeDana = "SRI";
        break;
      case Dan.cet:
        imeDana = "CET";
        break;
      case Dan.pet:
        imeDana = "PET";
        break;
      case Dan.sub:
        imeDana = "SUB";
        break;
      case Dan.ned:
        imeDana = "NED";
        break;
    }

    var listaZaOdabraniDan = calendarModel.listaZaOdabraniDan();
    return Scaffold(
      appBar: AppBar(
        title: Text("Day Details / $imeDana"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: null, heroTag: null, child: Icon(Icons.clear_all) ,backgroundColor: Colors.red,),
      body: ListView.builder(
        itemBuilder: (context, index) {
        Task task = listaZaOdabraniDan[index];
          return Dismissible(key: UniqueKey(), onDismissed: (direction) {
            calendarModel.izbrisiTask(task);
          },child: TaskWidget(task: task ));
        },
        itemCount: listaZaOdabraniDan.length,

      ),
    );
  }
}




class ObrnutiTaskWidget extends StatelessWidget{

  final Task task;

  const ObrnutiTaskWidget({Key key, this.task}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("lala");
  }

}
class TaskWidget extends StatefulWidget {
  final Task task;
  const TaskWidget({Key key, this.task}) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: BeveledRectangleBorder(
//          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(width: 1, color: Colors.deepPurpleAccent),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(widget.task.icon, size: 15,),
                  Text(
                    widget.task.naslov,
                    style: TextStyle(fontSize: 15, fontFamily: 'Fop'),
                  ),
                  FlatButton(
                    onPressed: (){
                    },
                    child: Icon(Icons.clear, size: 30, color: Colors.red,)
                    ,
                  )
                ],
              ),
            ),
            Image.network(
              widget.task.lokacijaSlike,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.task.detalji, softWrap: true,
                    style: TextStyle(fontSize: 16,fontFamily: 'Fop'),),
                  Text("Od ${widget.task.pocetak} do ${widget.task.kraj}",
                      style: TextStyle(fontSize: 16,fontFamily: 'Fop'))
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 28.0, bottom: 5),
              child: Container(
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.grey,
                    border: new Border.all(
                      width: 1.0,
                      color: Colors.black,)


                ),
                width: 147,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 9.0),
                      child: Text('Izvršen : ',style: TextStyle(fontFamily: 'Fop')),
                    ),
                    Checkbox(value: widget.task.izvrsen,
                      onChanged: _onChanged,),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _onChanged(bool value) {
    setState(() {
      widget.task.izvrsen = !widget.task.izvrsen;
    });
  }
}