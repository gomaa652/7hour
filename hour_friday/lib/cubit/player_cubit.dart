import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(PlayerInitial());

  List player = [];
  final TextEditingController name = TextEditingController();
  final TextEditingController postion = TextEditingController();
  final TextEditingController point = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('player');

  Future<void> addNewUser() async {
    try {
      await FirebaseFirestore.instance.collection('player').add({
        'name': name.text.trim(),
        'postion': postion.text.trim(),
        'point': point.text.trim(),
      });

      name.clear();
      postion.clear();
      point.clear();

      await getData();
      emit(PlayerSuccsful(player: player));
    } catch (e) {
      emit(PlayerError(message: e.toString()));
    }
  }

  Future<void> updateUser(String documentId, String newPoint) async {
    try {
      emit(PlayerLoading());

      await FirebaseFirestore.instance
          .collection('player')
          .doc(documentId)
          .update({'point': newPoint});

      await getData();
      emit(PlayerSuccsful(player: player));
    } catch (e) {
      emit(PlayerError(message: e.toString()));
    }
  }

  Future<void> getData() async {
    try {
      emit(PlayerLoading());

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('player')
          .where('point')
          .get();

      List<DocumentSnapshot> docs = querySnapshot.docs;
      docs.sort((a, b) {
        int pointA = int.tryParse(a['point']) ?? 0;
        int pointB = int.tryParse(b['point']) ?? 0;
        return pointB.compareTo(pointA);
      });

      player = docs;
      emit(PlayerSuccsful(player: player));
    } catch (e) {
      emit(PlayerError(message: e.toString()));
    }
  }

  Future<void> deleteUser(String documentId) async {
    try {
      emit(PlayerLoading());

      await FirebaseFirestore.instance
          .collection('player')
          .doc(documentId)
          .delete();

      await getData();
      emit(PlayerSuccsful(player: player));
    } catch (e) {
      emit(PlayerError(message: e.toString()));
    }
  }
}
