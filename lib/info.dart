import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'widgets/gradient.dart';
import 'widgets/privacy.dart';

import "cardstore.dart";

final cardStore = CardStore();

class SecondScreen extends StatelessWidget {
  SecondScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InfoScreen(title: 'HomePage'),
    );
  }
}

class InfoScreen extends StatelessWidget {
  InfoScreen({super.key, required this.title});
  final String title;
  final FocusNode fieldFocus = FocusNode();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: GradientBackground(
      child: Center(
        child: Column(
          children: [
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Container(
                    height: screenHeight / 2,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(5.0)),
                    width: screenWidth / 1.25,
                    margin: EdgeInsets.only(
                        left: screenWidth / 10,
                        right: screenWidth / 10,
                        bottom: screenHeight / 20),
                    child: Observer(
                      builder: (_) => Scrollbar(
                        thumbVisibility: true,
                        child: ListView.builder(
                          itemCount: cardStore.noteList.length,
                          itemBuilder: (context, index) {
                            return Observer(
                                builder: (_) => Container(
                                    margin: EdgeInsets.only(
                                        left: screenWidth / 30,
                                        right: screenWidth / 30,
                                        bottom: screenHeight / 50),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            cardStore.noteList[index],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenWidth / 22,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                      title: const Text(
                                                          'Editar texto'),
                                                      content: TextFormField(
                                                        initialValue: cardStore
                                                            .noteList[index],
                                                        onFieldSubmitted:
                                                            (value) async {
                                                          cardStore.editNote(
                                                              index, value);
                                                          await cardStore
                                                              .saveData()
                                                              .then((value) =>
                                                                  Navigator.pop(
                                                                      context));
                                                        },
                                                      ));
                                                });
                                          },
                                          child: const Icon(Icons.edit),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                      title: const Text(
                                                          'Deseja remover esse item?'),
                                                      content: SizedBox(
                                                        height:
                                                            screenHeight / 5,
                                                        child: Column(
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    screenWidth /
                                                                        2,
                                                                height:
                                                                    screenHeight /
                                                                        15,
                                                                child:
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          cardStore
                                                                              .removeNote(index);
                                                                          await cardStore
                                                                              .saveData()
                                                                              .then((value) => Navigator.pop(context));
                                                                        },
                                                                        style: const ButtonStyle(
                                                                            backgroundColor: MaterialStatePropertyAll(Color.fromARGB(
                                                                                255,
                                                                                69,
                                                                                189,
                                                                                111))),
                                                                        child: Text(
                                                                            'Sim',
                                                                            style:
                                                                                TextStyle(fontSize: screenWidth / 20, color: Colors.white))),
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      screenHeight /
                                                                          20),
                                                              SizedBox(
                                                                width:
                                                                    screenWidth /
                                                                        2,
                                                                height:
                                                                    screenHeight /
                                                                        15,
                                                                child:
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        style: const ButtonStyle(
                                                                            backgroundColor: MaterialStatePropertyAll(Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                0,
                                                                                0))),
                                                                        child: Text(
                                                                            'Não',
                                                                            style:
                                                                                TextStyle(fontSize: screenWidth / 20, color: Colors.white))),
                                                              ),
                                                            ]),
                                                      ));
                                                });
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ],
                                    )));
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: screenWidth / 10,
                          right: screenWidth / 10,
                          bottom: screenHeight / 33),
                      child: TextFormField(
                          controller: textController,
                          textAlign: TextAlign.center,
                          focusNode: fieldFocus,
                          onFieldSubmitted: (value) async {
                            if (textController.text.isNotEmpty) {
                              cardStore.addNote(value);
                              textController.text = '';
                              fieldFocus.requestFocus();
                              await cardStore.saveData();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Digite seu texto',
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7)),
                          ))),
                ])),
            PrivacyPolicy()
          ],
        ),
      ),
    )));
  }
}
