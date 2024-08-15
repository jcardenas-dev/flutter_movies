import 'package:flutter/material.dart';

class NowPlayingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reproduciendo'),
      ),
      body: Center(
        child: Text('Aquí se mostrarán las películas en reproducción'),
      ),
    );
  }
}
