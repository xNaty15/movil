//import 'dart:developer';

import 'package:get/get.dart';
//import 'package:peliculas_/components/movies/models/peliculas_model.dart';
import 'package:peliculas_practica/components/series/models/series_model.dart';
import 'package:peliculas_practica/components/shared/request_handler.dart';
import 'package:peliculas_practica/components/shared/request_model.dart';
import 'package:peliculas_practica/components/utils/constantes.dart';

class SeriesController extends GetxController {
  //Definiendo variables
  final _cargando = false.obs;

  //Rx = variable reactiva, que puede cambiar
  final RxList<SeriesModel> _listaSeries = <SeriesModel>[].obs;

  final _request = RequestHandler();

  late RequestModel response; // es una variable que se evaluara despues

  // cuando se inyecte el controlador se mandara a ejecutar la funcion de getPeliculas
  @override
  void onInit() async {
    super.onInit();
    response = await getSeries();
  }

  //hacer la peticion
  Future<RequestModel> getSeries() async {
    cargando = true;

    final data = await _request.requestGet(
      host: host,
      endpoint: seriesTopRated,
    ); //aqui hago la petción

    if (data.results.isNotEmpty) {
      listaSeries = data.results.map((e) => SeriesModel.fromJson(e)).toList();
    }

    cargando = false;

    return data;
  }

  // Getters y setters
  bool get cargando => _cargando.value;
  set cargando(bool value) => _cargando.value = value;

  List<SeriesModel> get listaSeries => _listaSeries;
  set listaSeries(List<SeriesModel> series) => _listaSeries.assignAll(series);
}//series no es realativo a la data de series 
