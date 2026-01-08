import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peliculas_practica/components/movies/controllers/peliculas_controller.dart';
import 'package:peliculas_practica/components/movies/views/card_peliculas.dart';
//import 'package:skeletonizer/skeletonizer.dart';

class PeliculasView extends StatelessWidget {
  PeliculasView({super.key});

  final peliculasController = Get.put<PeliculasController>(
    PeliculasController(),
  ); // inyectando el controlador

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => peliculasController.cargando
            ? Center(child: CircularProgressIndicator())
            : GetBuilder(
                init: peliculasController,
                builder: (PeliculasController controller) {
                  return ListView.builder(
                    // itemBuilder: (content, index) {
                    //  final pelicula = controller.listaPeliculas[index];
                    //return CardPeliculas(peliculas: pelicula);
                    //},
                    itemCount: controller.listaPeliculas.length,
                    itemBuilder: (context, index) {
                      final pelicula = controller.listaPeliculas[index];
                      return CardPeliculas(peliculas: pelicula);
                    },
                  );
                },
              ),
      ),
    );
  }
}
