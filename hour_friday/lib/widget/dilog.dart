import 'package:flutter/material.dart';

class DilogShow extends StatelessWidget {
  const DilogShow({super.key, required this.keys, required this.playerName , this.onPressed});

  final  TextEditingController keys;
  final TextEditingController playerName;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text('Add player'),
          content: Column(
            children: [
              SizedBox(
                child: TextField(
                  controller: keys,
                  decoration: const InputDecoration(
                      label: Text('key'), border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                child: TextField(
                  controller: playerName,
                  decoration: const InputDecoration(
                      label: Text('Name'), border: OutlineInputBorder()),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 22)),
              onPressed: onPressed,
              child:  const Text('Add'),
            )
          ],
        );
  }
}