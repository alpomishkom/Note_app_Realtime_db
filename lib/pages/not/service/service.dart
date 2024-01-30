import 'package:firebase_database/firebase_database.dart';

class Srvc {
  static final ref = FirebaseDatabase.instance.ref();

  static Future<void> create(String path, Map<String, dynamic> data) async {
    var key = ref.child(path).push().key;
    await ref.child(path).child(key!).set(data);
  }

  static Future<List<DataSnapshot>> read(String path) async {
    List<DataSnapshot> list = [];
    DatabaseReference parentP = ref.child(path);
    DatabaseEvent childP =  await parentP.once();
    for (var e in childP.snapshot.children) {
      list.add(e);
    }
    return list;
  }

  static Future<void> DELET(String path,String id) async {
    await ref.child(path).child(id).remove();
  }

  static Future<void> UPDATE(String path,String id,Map<String,dynamic> data) async {
    await ref.child(path).child(id).update(data);
  }
}
