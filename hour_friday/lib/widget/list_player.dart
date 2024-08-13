import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hour_friday/cubit/player_cubit.dart';

class ListPlayer extends StatefulWidget {
  const ListPlayer({super.key, required this.player, required this.onRefresh});

  final List player;
  final Future<void> Function() onRefresh;

  @override
  State<ListPlayer> createState() => _ListPlayerState();
}

class _ListPlayerState extends State<ListPlayer> {
  late List<DocumentSnapshot> _players;

  @override
  void initState() {
    super.initState();
    _players = widget.player.cast<DocumentSnapshot>();
  }

  Future<void> showMyDialog(String documentId) async {
    final TextEditingController pointUpdateController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Point'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: pointUpdateController,
                  decoration: const InputDecoration(
                    label: Text('Update'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                BlocProvider.of<PlayerCubit>(context).updateUser(
                  documentId,
                  pointUpdateController.text.trim(),
                ).then((_) {
                  widget.onRefresh(); // إعادة تحميل البيانات بعد التحديث
                });
                Navigator.of(context).pop();
              },
              child: const Text('Update Point'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: ListView.builder(
        itemCount: _players.length,
        itemBuilder: (context, index) {
          final documentId = _players[index].id; // الحصول على المعرف الخاص بالمستند

          return Dismissible(
            key: Key(documentId),
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              // حذف العنصر من القائمة
              final removedPlayer = _players[index];
              _players.removeAt(index);

              // حذف العنصر من Firestore
              BlocProvider.of<PlayerCubit>(context).deleteUser(documentId);

              // إظهار رسالة تأكيد
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${removedPlayer['name']} dismissed'),
                ),
              );
            },
            background: Container(color: Colors.red),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _players[index]['name'],
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        _players[index]['postion'],
                        style: const TextStyle(fontSize: 26),
                      ),
                    ],
                  ),
                  Text(
                    '${_players[index]['point']}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              onTap: () {
                showMyDialog(documentId); // تمرير المعرف إلى الدالة
              },
            ),
          );
        },
      ),
    );
  }
}
