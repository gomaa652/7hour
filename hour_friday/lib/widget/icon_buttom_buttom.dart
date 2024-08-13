import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IconButtomButtom extends StatefulWidget {
  const IconButtomButtom({
    super.key,
    required this.namePlayer,
  });

  final String namePlayer;

  @override
  State<IconButtomButtom> createState() => _IconButtomButtomState();
}

class _IconButtomButtomState extends State<IconButtomButtom> {
  TextEditingController keys = TextEditingController();
  TextEditingController name = TextEditingController();

  String? sss;

  void addPlayer() {
    dialog();
  }

  Future<void> dialog() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text('Add new player'),
          content: Column(
            children: [
              SizedBox(
                child: TextField(
                  controller: keys,
                  decoration: const InputDecoration(
                      label: Text('Key'), border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: TextField(
                  controller: name,
                  decoration: const InputDecoration(
                      label: Text('Player Name'), border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 22)),
              child: const Text('Add'),
              onPressed: () {
                setAndGetNamePlayer(keys.text, name.text);
                sss = name.text;
                Navigator.of(context).pop();
                // keys.clear();
                // name.clear();
                setState(() {});
              },
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    keys.dispose();
    name.dispose();
  }

  Future setAndGetNamePlayer(String key, String playerName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, playerName);
    sss = sharedPreferences.getString(key);
  }

  getNamePlayer(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     sss = sharedPreferences.getString(key);
      setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          sss?? '${getNamePlayer(widget.namePlayer)}',
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        GestureDetector(
            onTap: () {
              addPlayer();
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: const Color.fromARGB(255, 214, 139, 0)),
            )),
        
      ],
    );
  }
}
