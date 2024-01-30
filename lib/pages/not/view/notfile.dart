import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:not/pages/home/view/home_not_view.dart';
import 'package:not/pages/not/model/model.dart';
import 'package:not/pages/not/service/service.dart';

class NotFile extends StatefulWidget {
  const NotFile({super.key});

  @override
  State<NotFile> createState() => _NotFileState();
}

class _NotFileState extends State<NotFile> {
  DateTime dateTime = DateTime.now();

  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();

Future<void> collect(Not data) async {
 await Srvc.create("Not", data.toJson());
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.black,
                  context: context,
                  builder: (context) => Column(
                        children: [
                          TextButton(
                              onPressed: () async {
                               await collect(Not(title: title.text, subtitle: subTitle.text));
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeNoteView()));
                              },
                              child: Text(
                                "GET",
                                style: TextStyle(color: Colors.white),
                              )),
                          Divider(),
                          TextButton(
                              onPressed: () {},
                              child: Text("UBDATE",
                                  style: TextStyle(color: Colors.white))),
                          Divider(),
                          TextButton(
                              onPressed: () {},
                              child: Text("DELET",
                                  style: TextStyle(color: Colors.white))),
                          Divider(),
                        ],
                      ));
            },
            icon: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: title,
                maxLines: 1,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Nomi",
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              Text(
                "${dateTime}",
                style: TextStyle(color: Colors.white),
              ),
              TextFormField(
                controller: subTitle,
                maxLines: 3,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Yozishdi boshlang",
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
