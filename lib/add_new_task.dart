import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/calendar.dart';
import 'calendar.dart';

class AddNewTask extends StatefulWidget {
  //final varijable primamo preko kontruktora
  //i ako imamo state, mozemo im pristupiti sa widget.imeVarijable
  final CalendarModel model;

  AddNewTask(this.model);

  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  //text editing controller se koristi da cuva text od TextFormFielda.
  // Textu pristupamo sa controller.value.text;
  TextEditingController _naslovController = TextEditingController();
  TextEditingController _detaljiController = TextEditingController();
  TextEditingController _linkNaSlikuController = TextEditingController();

  //ovdje spremamo state (vrijednosti) od drop down menija
  //upravo zbog toga sto cuvamo state, ovo je statefull widget
  Dan odabraniDan = Dan.pon;
  int pocetniSat = 0;
  int zavrsniSat = 1;
  IconData ikona = Icons.ac_unit;

  Task taskovi;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: Column(
          children: <Widget>[
            //prvi text form
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: TextStyle(fontFamily: 'Fop'),
                controller: _naslovController,
                //probajte se igrati sa parametrima od input dekoracije i od input bordera, ctrl P
                decoration: InputDecoration(
                    labelText: "Naslov",
                    border:
                        UnderlineInputBorder()), //ovdje mozete probati OutlineInputBorder()
              ),
            ),
            //drugi text form
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: TextStyle(fontFamily: 'Fop'),
                controller: _detaljiController,
                decoration: InputDecoration(
                    labelText: "Detalji", border: UnderlineInputBorder()),
              ),
            ),
            //treci text form
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: TextStyle(fontFamily: 'Fop'),
                controller: _linkNaSlikuController,
                decoration: InputDecoration(
                    labelText: "Link Na Sliku", border: UnderlineInputBorder()),
              ),
            ),
            //dan dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Odaberi dan",style: TextStyle(fontFamily: 'Fop')),
                //ovdje se radi dropdown button
                DropdownButton<Dan>(
                    value: odabraniDan,
                    //vrijednost je spremljena u state odabraniDan
                    items: _createDanMenuItems(),
                    //funkcija koja radi listu itema
                    onChanged: (value) => {
                          //funkcija koja se izvrsava kada se promijeni vrijednost
                          setState(() {
                            odabraniDan =
                                value; // moramo sami updateati state od odabranog dana, inace se promjena ne spremi nigdje
                          })
                        }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Odaberi pocetni sat"),
                DropdownButton<int>(
                    value: pocetniSat,
                    items: _createSatMenuItems(),
                    onChanged: (value) => {
                          setState(() {
                            pocetniSat = value;
                          })
                        }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Odaberi zavrsni sat"),
                DropdownButton<int>(
                    value: zavrsniSat,
                    items: _createSatMenuItems(),
                    onChanged: (value) => {
                          setState(() {
                            zavrsniSat = value;
                          })
                        }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Odaberi ikonu"),
                DropdownButton<IconData>(
                    value: ikona,
                    items: _createIconMenuItems(),
                    onChanged: (value) => {
                          setState(() {
                            ikona = value;
                          })
                        }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("OK"),
                  color: Colors.green,
                  onPressed: () {
                    //spremamo u model
                        widget.model.dodajTask(Task(
                        false,
                        _naslovController.value.text,
                        _detaljiController.value.text,
                        ikona,
                        pocetniSat,
                        zavrsniSat,
                        _linkNaSlikuController.value.text,
                        odabraniDan));

                    Navigator.of(context).pop(); // popamo navigator
                  },
                ),
                RaisedButton(
                  child: Text("CANCEL"),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop(); // samo pop
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> _createSatMenuItems() {
    List<DropdownMenuItem<int>> list = [];

    //for petlja za 24 sata
    for (var i = 0; i < 24; ++i) {
      //dodajemo u listu DropDownMenuItem. ima value,
      // koji se poziva kada se promijeni vrijednost,
      // i child koji je vizualna reprezentacija
      list.add(DropdownMenuItem<int>(
        value: i,
        child: Text(i.toString()),
      ));
    }
    return list;
  }

  List<DropdownMenuItem<IconData>> _createIconMenuItems() {
    List<DropdownMenuItem<IconData>> list = [];
    var icons = [
      Icons.ac_unit,
      Icons.adb,
      Icons.call_missed,
      Icons.airline_seat_recline_normal
    ];
    //for each funkcija poziva funkciju na svaki clan liste.
    // kao argument funkcije dobijate taj clan.
    icons.forEach((icon) {
      list.add(DropdownMenuItem<IconData>(
        value: icon,
        child: Icon(icon),
      ));
    });
    return list;
  }

  List<DropdownMenuItem<Dan>> _createDanMenuItems() {
    List<DropdownMenuItem<Dan>> list = [];

    Dan.values.forEach((dan) {
      var menuItem = DropdownMenuItem(
        value: dan,
        child: Text(_returnStringForDan(dan),style: TextStyle(fontFamily: 'Fop')),
      );
      list.add(menuItem);
    });
    return list;
  }

  //pomocna funkcija
  String _returnStringForDan(Dan dan) {
    var imeDana;
    switch (dan) {
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

    return imeDana;
  }

  bool provjeri(Task task, Map<Dan, List<Task>> taskovi) {
    var taskoviDan = taskovi[task.dan];
    var provjeraUspjesna=taskoviDan.every((currentTask) {
      if (task.naslov == currentTask.naslov) {
        return false;

      } else {
        return true;
      }
    });
    return provjeraUspjesna;
  }
}
