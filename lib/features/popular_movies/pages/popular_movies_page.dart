import 'package:flutter/material.dart';

class PopularMoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas Populares'),
      ),
      body: Center(
        child: Text('Aquí se mostrarán las películas populares'),
      ),
    );
  }
}
