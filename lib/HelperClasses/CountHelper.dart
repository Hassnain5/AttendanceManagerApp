

import 'package:cloud_firestore/cloud_firestore.dart';

class CountHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<int> countStudent() {

    return   _firestore
        .collection("Students").snapshots()
        .map((snapshot)=>snapshot.docs.length);

  }
  Stream<int> countPresent() {

    return   _firestore
        .collection("Students").snapshots()
        .map((snapshot)=>snapshot.docs.length);

  }
  // Stream<int> countPresent() {
  //
  //  SnapshotMetadata data= _firestore
  //       .collection("Students").s
  //   return
  //       .map((snapshot)=>snapshot.docs.length);
  //
  // }

}
