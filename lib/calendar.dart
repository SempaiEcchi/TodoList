import 'dart:core';

import 'package:flutter/material.dart';

class CalendarModel {

  Dan odabraniDan;

  Map<Dan, List<Task>> taskovi = {
    Dan.pon: [
    Task(false, "a", "", Icons.ac_unit, 8, 1, "", Dan.pet)
    ],
    Dan.uto: [

    ],
    Dan.sri: [],
    Dan.cet: [],
    Dan.pet: [],
    Dan.sub: [],
    Dan.ned: [],
  };

  void dodajTask(Task task) {
    taskovi[task.dan].add(task);
  }

  void izbrisiTask(Task task) {
    taskovi[task.dan].remove(task);
  }

  List<Task> listaZaOdabraniDan(){
    return taskovi[odabraniDan];
  }

}

class Task {
  bool izvrsen;
  String naslov;
  String detalji;
  IconData icon;
  int pocetak;
  int kraj;
  String lokacijaSlike;
  Dan dan;

  Task(this.izvrsen, this.naslov, this.detalji, this.icon, this.pocetak,
      this.kraj, this.lokacijaSlike, this.dan);
}

enum Dan { pon, uto, sri, cet, pet, sub, ned }
