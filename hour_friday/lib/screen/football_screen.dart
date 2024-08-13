import 'package:flutter/material.dart';
import 'package:hour_friday/screen/list_player_screen.dart';
import 'package:hour_friday/widget/icon_buttom_buttom.dart';
import 'package:hour_friday/widget/icon_buttom_top.dart';

class FootballScreen extends StatefulWidget {
  const FootballScreen({super.key, required this.onThemeChanged});
  final void Function(ThemeMode) onThemeChanged;

  @override
  State<FootballScreen> createState() => _FootballScreenState();
}

class _FootballScreenState extends State<FootballScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Screen'),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.wb_sunny // أيقونة الشمس لوضع الضوء
                  : Icons.nightlight_round, // أيقونة القمر للوضع الداكن
            ),
            onPressed: () {
              final currentMode = Theme.of(context).brightness;
              final newMode = (currentMode == Brightness.dark)
                  ? ThemeMode.light
                  : ThemeMode.dark;
              widget.onThemeChanged(newMode); // تغيير الثيم
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/—Pngtree—aerial photograph of the football_1683355.jpg'),
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 27),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildExitButton(context),
              _buildIconButtons(),
              const SizedBox(height: 110),
              _buildBottomRow(),
              const SizedBox(height: 35),
              _buildBottomColumn(),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the exit button
  Widget _buildExitButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ListPlayerScreen(),
        ));
      },
      icon: const Icon(Icons.exit_to_app, color: Colors.white),
    );
  }

  // Builds the set of icon buttons
  Widget _buildIconButtons() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const IconButtoms(namePlayer: '1'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: screenWidth * 0.4, // Adjust width as needed
              child: const IconButtoms(namePlayer: '2'),
            ),
            SizedBox(
              width: screenWidth * 0.4, // Adjust width as needed
              child: const IconButtoms(namePlayer: '3'),
            ),
          ],
        ),
        const SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: screenWidth * 0.4, // Adjust width as needed
              child: const IconButtoms(namePlayer: '4'),
            ),
            SizedBox(
              width: screenWidth * 0.4, // Adjust width as needed
              child: const IconButtoms(namePlayer: '5'),
            ),
          ],
        ),
      ],
    );
  }

  // Builds the bottom row of icon buttons
  Widget _buildBottomRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButtomButtom(namePlayer: '10'),
        IconButtomButtom(namePlayer: '9'),
      ],
    );
  }

  // Builds the bottom column of icon buttons
  Widget _buildBottomColumn() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButtomButtom(namePlayer: '8'),
            IconButtomButtom(namePlayer: '7'),
          ],
        ),
        IconButtomButtom(namePlayer: '6'),
      ],
    );
  }
}
