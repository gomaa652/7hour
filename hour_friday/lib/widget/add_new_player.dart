import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hour_friday/cubit/player_cubit.dart';

class AddNewPlayer extends StatefulWidget {
  const AddNewPlayer({super.key});

  @override
  State<AddNewPlayer> createState() => _AddNewPlayerState();
}

class _AddNewPlayerState extends State<AddNewPlayer> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Player'),
      ),
      body: Form(
        key: globalKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: TextField(
                  controller: BlocProvider.of<PlayerCubit>(context).name,
                  decoration: const InputDecoration(
                      label: Text('Name'), border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: TextField(
                  controller: BlocProvider.of<PlayerCubit>(context).postion,
                  decoration: const InputDecoration(
                      label: Text('Postion'), border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: TextField(
                  controller: BlocProvider.of<PlayerCubit>(context).point,
                  decoration: const InputDecoration(
                      label: Text('Point'), border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<PlayerCubit>(context).addNewUser();
                    // BlocProvider.of<PlayerCubit>(context).addUser();
                    Navigator.of(context).pop();
                    BlocProvider.of<PlayerCubit>(context).name.clear();
                    BlocProvider.of<PlayerCubit>(context).postion.clear();
                    BlocProvider.of<PlayerCubit>(context).point.clear();
                  },
                  child: const Text('Add',style: TextStyle(fontSize: 22),))
            ],
          ),
        ),
      ),
    );
  }
}
