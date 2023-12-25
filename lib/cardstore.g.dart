// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cardstore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CardStore on _CardStore, Store {
  late final _$noteListAtom =
      Atom(name: '_CardStore.noteList', context: context);

  @override
  ObservableList<String> get noteList {
    _$noteListAtom.reportRead();
    return super.noteList;
  }

  @override
  set noteList(ObservableList<String> value) {
    _$noteListAtom.reportWrite(value, super.noteList, () {
      super.noteList = value;
    });
  }

  late final _$_CardStoreActionController =
      ActionController(name: '_CardStore', context: context);

  @override
  void addNote(dynamic value) {
    final _$actionInfo =
        _$_CardStoreActionController.startAction(name: '_CardStore.addNote');
    try {
      return super.addNote(value);
    } finally {
      _$_CardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editNote(dynamic index, dynamic value) {
    final _$actionInfo =
        _$_CardStoreActionController.startAction(name: '_CardStore.editNote');
    try {
      return super.editNote(index, value);
    } finally {
      _$_CardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeNote(dynamic index) {
    final _$actionInfo =
        _$_CardStoreActionController.startAction(name: '_CardStore.removeNote');
    try {
      return super.removeNote(index);
    } finally {
      _$_CardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
noteList: ${noteList}
    ''';
  }
}
