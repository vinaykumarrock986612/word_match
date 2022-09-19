import 'package:flutter/material.dart';
import 'package:word_game/grid/grid_entry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isPressed = true;
          });
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => GridEntry(),
              ));
        },
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        child: Container(
          height: _isPressed ? 75 : 80,
          width: _isPressed ? 180 : 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _isPressed
                ? themeData.colorScheme.background
                : themeData.colorScheme.primary,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text("PLAY", style: TextStyle(fontSize: 25, color: Colors.white),),
        ),
      ),
    );
  }
}
