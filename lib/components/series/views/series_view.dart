import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:peliculas_/components/movies/controllers/peliculas_controller.dart';
//import 'package:peliculas_/components/movies/views/card_peliculas.dart';
import 'package:peliculas_practica/components/series/controllers/series_controller.dart';
import 'package:peliculas_practica/components/series/views/card_series.dart';
//import 'package:skeletonizer/skeletonizer.dart';

class SeriesView extends StatelessWidget {
  SeriesView({super.key});

  final seriesController = Get.put<SeriesController>(
    SeriesController(),
  ); // inyectando el controlador

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => seriesController.cargando
            ? Center(child: CircularProgressIndicator())
            : GetBuilder(
                init: seriesController,
                builder: (SeriesController controller) {
                  return ListView.builder(
                    // itemBuilder: (content, index) {
                    //  final series = controller.listaSeries[index];
                    //  return CardSeries(series: series);
                    // },
                    itemCount: controller.listaSeries.length,
                    itemBuilder: (context, index) {
                      final pelicula = controller.listaSeries[index];
                      return CardSeries(series: pelicula);
                    },
                  );
                },
              ),
      ),
    );
  }
}
