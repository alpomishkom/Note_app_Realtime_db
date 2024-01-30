import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:not/pages/not/model/model.dart';
import 'package:not/pages/not/service/service.dart';
import '../../not/view/notfile.dart';

class HomeNoteView extends StatefulWidget {
  const HomeNoteView({Key? key}) : super(key: key);

  @override
  State<HomeNoteView> createState() => _HomeNoteViewState();
}

class _HomeNoteViewState extends State<HomeNoteView> {
  List<DataSnapshot> list = [];
  bool isLoading = true;

  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();

  Future<void> redalAll() async {
    list = await Srvc.read("Not");
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    redalAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Not",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, index) {
                  return Card(
                    color: Colors.white10,
                    child: ListTile(
                      onLongPress: () async {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            scrollControlDisabledMaxHeightRatio: 0.1,
                            context: context,
                            builder: (context) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor: Colors.grey.shade900,
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller: title,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    decoration: InputDecoration(
                                                      hintText: "Nomi",
                                                      hintStyle: TextStyle(
                                                          color: Colors.white),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    controller: subTitle,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Yozishdi boshlang",
                                                      hintStyle: TextStyle(
                                                          color: Colors.white),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(onPressed: () async{
                                                var data =  Not(title: title.text, subtitle: subTitle.text);
                                                await  Srvc.UPDATE("Not", list[index].key.toString(),data.toJson());
                                                  await redalAll();
                                                  Navigator.pop(context);
                                                }, child: Text("SAVE")),
                                                TextButton(onPressed: (){
                                                  Navigator.pop(context);
                                                }, child: Text("CLOSE")),
                                              ],
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          CupertinoIcons.refresh,
                                          color: CupertinoColors.white,
                                        ),
                                      ),
                                      const Gap(20),
                                      IconButton(
                                        onPressed: () async {
                                          await Srvc.DELET("Not",
                                              list[index].key.toString());
                                          await redalAll().then((value) {
                                            setState(() {});
                                          });
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          CupertinoIcons.delete,
                                          color: CupertinoColors.destructiveRed,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            });
                      },
                      title: Text(
                        (list[index].value as Map)["title"],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                      subtitle: Text(
                        (list[index].value as Map)["subtitle"],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: Colors.grey,
        elevation: 10,
        splashColor: Colors.black,
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => NotFile()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
