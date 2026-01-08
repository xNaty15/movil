// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peliculas_practica/components/home_page.dart';
import 'package:peliculas_practica/components/movies/controllers/pelicula_cast_controller.dart';
import 'package:peliculas_practica/components/movies/controllers/pelicula_detalle_controller.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'App de Películas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: GlobalBindings(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    // Registramos ambos controladores al iniciar la app
    Get.lazyPut<PeliculaDetalleController>(() => PeliculaDetalleController());
    Get.lazyPut<PeliculaCastController>(() => PeliculaCastController());
  }
}
