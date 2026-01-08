import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peliculas_practica/components/movies/models/peliculas_model.dart';
import 'package:peliculas_practica/components/movies/views/detalle_peliculas.dart';
import 'package:peliculas_practica/components/movies/views/pelicula_detalle_view.dart';

class CardPeliculas extends StatelessWidget {
  const CardPeliculas({super.key, required this.peliculas});
  final PeliculasModel peliculas; // definiendo un paramentro

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 9,
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  height: 400,
                  'https://image.tmdb.org/t/p/w500/${peliculas.posterPath}',
                ),
                SizedBox(height: 10),
                Text(
                  peliculas.title,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),

                Padding(
                  padding: EdgeInsetsGeometry.directional(
                    start: 20,
                    end: 20,
                  ), //EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      peliculas.overview,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      //onPressed: () =>
                      //   Get.to(DetallePeliculas(peliculasModel: peliculas)),
                      onPressed: () => Get.to(
                        () => PeliculaDetalleView(idPelicula: peliculas.id),
                      ),

                      child: Text(
                        'Ver mas',
                        style: TextStyle(fontSize: 20, color: Colors.purple),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
