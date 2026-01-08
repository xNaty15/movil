import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peliculas_practica/components/movies/controllers/pelicula_cast_controller.dart';

//import 'package:peliculas_/components/movies/controllers/pelicula_detalle_controller.dart';
//import 'package:peliculas_/components/movies/views/lista_actores.dart';
//import 'package:peliculas_/components/movies/controllers/pelicula_detalle_controller.dart';
class ListaActoresPage extends StatelessWidget {
  ListaActoresPage({super.key});

  final controller = Get.find<PeliculaCastController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actores'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.cargando) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.cast.isEmpty) {
          return const Center(child: Text('No se encontraron actores.'));
        }

        return ListView.builder(
          itemCount: controller.cast.length,
          itemBuilder: (context, index) {
            final actor = controller.cast[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: actor.profilePath != null
                    ? NetworkImage(
                        'https://image.tmdb.org/t/p/w200${actor.profilePath}',
                      )
                    : const AssetImage('assets/images/no_image.png')
                          as ImageProvider,
              ),
              title: Text(actor.name),
              subtitle: Text(actor.character ?? ''),
            );
          },
        );
      }),
    );
  }
}
