import 'package:mobx/mobx.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

part 'cardstore.g.dart';

class CardStore = _CardStore with _$CardStore;

abstract class _CardStore with Store {
  @observable
  var noteList = ObservableList<String>.of([]);

  @action
  void addNote(value) {
   noteList.add(value);
  }
  @action
  void editNote(index, value) {
    noteList[index] = value;
  }
  @action
  void removeNote(index) {
    noteList.removeAt(index);
  }

  _CardStore(){
    retrieveData();
  }

  String serializeList() {
    return jsonEncode(noteList.toList());
  }

  void deserializeList(String jsonString) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    noteList.clear();
    noteList.addAll(jsonList.cast<String>());
  }

  Future<void> saveData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('key', serializeList());
  }

  Future<void> retrieveData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonString = preferences.getString('key');
    if (jsonString != null) {
      deserializeList(jsonString);
    }
  }
}
