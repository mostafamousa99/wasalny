import 'package:cloud_firestore/cloud_firestore.dart';

class Fire {
  var c = "cairo";
  var listid = [];
  int number;
  var tourlist = [];

  getdoc() async {
    await FirebaseFirestore.instance
        .collection('info')
        .where('from', isEqualTo: "cairo")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        listid.add(element.id);
        number = listid.length;
        tourlist.add("tour$number");

        print(element.id);
        print(listid);
      });
    });
  }

  Stream<String> _clock() async* {
    await FirebaseFirestore.instance
        .collection('info')
        .where('from', isEqualTo: "cairo")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        listid.add(element.id);
        number = listid.length;
        tourlist.add("tour$number");

        print(element.id);
        print(listid);
      });
    });
  }
}
