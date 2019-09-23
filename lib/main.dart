import 'package:flutter/material.dart';
import 'package:flutter_app/add_new_task.dart';
import 'package:flutter_app/app_constants.dart';
import 'package:flutter_app/calendar.dart';
import 'package:flutter_app/day_details_screen.dart';

void main() {
  runApp(Aplikacija());
}

class Aplikacija extends StatefulWidget {
  @override
  _AplikacijaState createState() => _AplikacijaState();
}

class _AplikacijaState extends State<Aplikacija> {
  var _calendarModel = CalendarModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RoutePath.dayDetails: (BuildContext context) =>
            DayDetailsScreen(_calendarModel),
        RoutePath.homeScreen: (BuildContext context) =>
            HomeScreen(_calendarModel),
      },
      initialRoute: RoutePath.homeScreen,
    );
  }
}

class HomeScreen extends StatefulWidget {
  final CalendarModel calendarModel;
  const HomeScreen(
      this.calendarModel, {
        Key key,
      }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("TODO List",style: TextStyle(fontFamily: 'Fop')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15,top: 15),
                      child: Text('Broj izvrsenih / broj zadataka',style: TextStyle(fontFamily: 'Fop')),
                    ),
                  ],
                ),
                DanWidget("PONEDJELJAK", widget.calendarModel.taskovi[Dan.pon].where((i) => i.izvrsen).toList().length,
                    Colors.red, () => _pozoviRoute(Dan.pon, context),widget.calendarModel.taskovi[Dan.pon].length),
                DanWidget("UTORAK", widget.calendarModel.taskovi[Dan.uto].where((i) => i.izvrsen).toList().length,
                    Colors.orange, () => _pozoviRoute(Dan.uto, context),widget.calendarModel.taskovi[Dan.uto].length),
                DanWidget("SRIJEDA", widget.calendarModel.taskovi[Dan.sri].where((i) => i.izvrsen).toList().length,
                    Colors.orangeAccent, () => _pozoviRoute(Dan.sri, context),widget.calendarModel.taskovi[Dan.sri].length),
                DanWidget("CETVRTAK", widget.calendarModel.taskovi[Dan.cet].where((i) => i.izvrsen).toList().length,
                    Colors.green, () => _pozoviRoute(Dan.cet, context),widget.calendarModel.taskovi[Dan.cet].length),
                DanWidget("PETAK", widget.calendarModel.taskovi[Dan.pet].where((i) => i.izvrsen).toList().length,
                    Colors.blue, () => _pozoviRoute(Dan.pet, context),widget.calendarModel.taskovi[Dan.pet].length),
                DanWidget("SUBOTA", widget.calendarModel.taskovi[Dan.sub].where((i) => i.izvrsen).toList().length,
                    Colors.purple, () => _pozoviRoute(Dan.sub, context),widget.calendarModel.taskovi[Dan.sub].length),
                DanWidget("NEDJELJA", widget.calendarModel.taskovi[Dan.ned].where((i) => i.izvrsen).toList().length,
                    Colors.teal, () => _pozoviRoute(Dan.ned, context),widget.calendarModel.taskovi[Dan.ned].length),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FloatingActionButton(child: Icon(Icons.clear_all),
                        heroTag: null,
                        backgroundColor: Colors.red,
                        onPressed: ()=>{} ,
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          //ovdje napraviti novi widget
//                        await showDialog(context: context, builder: (context) => AddNewTaskExercise(widget.calendarModel));
            await showDialog(context: context, builder: (context) => AddNewTask(widget.calendarModel));
                          setState(() {

                          });
                        },                      child: Icon(Icons.today),
                      ),
                    ],
                  ),
                ),

              ],
            ),


          ],

        ),
      ),


    );
  }

  _pozoviRoute(Dan dan, BuildContext context) {
    widget.calendarModel.odabraniDan = dan;
    Navigator.of(context).pushNamed("/dayDetails");
  }

}

class DanWidget extends StatelessWidget {
  final String dan;
  final int brojTaskova;
  final Color backgroundBoja;
  final int brojIzvrsenih;
  final Function onPressed;

  const DanWidget(this.dan, this.brojTaskova, this.backgroundBoja, this.onPressed, this.brojIzvrsenih);



  @override
  Widget build(BuildContext context) {

    return FlatButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
              height: 70,
              color: backgroundBoja,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      dan,

                      style: TextStyle(fontSize: 18, color: Colors.white,fontFamily: 'Fop' ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),

                    child:

                    Text("${brojTaskova.toString()+" / ${brojIzvrsenih.toString()}"}",
                        style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Fop')),
                  )
                ],
              )),
        ),
      ),
    );
  }
}


