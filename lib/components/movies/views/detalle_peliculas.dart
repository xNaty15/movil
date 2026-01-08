import 'package:flutter/material.dart';
import 'package:peliculas_practica/components/movies/models/peliculas_model.dart';

class DetallePeliculas extends StatelessWidget {
  const DetallePeliculas({super.key, required this.peliculasModel});
  final PeliculasModel peliculasModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(peliculasModel.title)),
      body: Column(children: [Text('Diseño general')]),
    );
  }
}

//no la use, viejo
