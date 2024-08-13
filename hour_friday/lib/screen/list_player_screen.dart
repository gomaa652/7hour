import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hour_friday/cubit/player_cubit.dart';
import 'package:hour_friday/widget/add_new_player.dart';
import 'package:hour_friday/widget/list_player.dart';

class ListPlayerScreen extends StatefulWidget {
  const ListPlayerScreen({super.key});

  @override
  State<ListPlayerScreen> createState() => _ListPlayerScreenState();
}

class _ListPlayerScreenState extends State<ListPlayerScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    BlocProvider.of<PlayerCubit>(context).getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Point', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
        leading: const Padding(
          padding: EdgeInsets.only(top: 20.0, left: 8.0),
          child: Text('Details', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      body: BlocBuilder<PlayerCubit, PlayerState>(
        builder: (context, state) {
          if (state is PlayerSuccsful) {
            return RefreshIndicator(
              onRefresh: _loadData,
              child: ListPlayer(
                player: state.player,
                onRefresh: _loadData,
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddNewPlayer()),
          );
          if (result == true) {
            _loadData(); // إعادة تحميل البيانات عند العودة
          }
        },
        child: const Text('Add player'),
      ),
    );
  }
}
