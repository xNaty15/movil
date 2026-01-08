//import 'dart:developer';

import 'package:get/get.dart';
import 'package:peliculas_practica/components/movies/models/peliculas_model.dart';
import 'package:peliculas_practica/components/shared/request_handler.dart';
import 'package:peliculas_practica/components/shared/request_model.dart';
import 'package:peliculas_practica/components/utils/constantes.dart';

class PeliculasController extends GetxController {
  //Definiendo variables
  final _cargando = false.obs;

  //Rx = variable reactiva, que puede cambiar
  final RxList<PeliculasModel> _listaPeliculas = <PeliculasModel>[].obs;

  final _request = RequestHandler();

  late RequestModel response; // es una variable que se evaluara despues

  // cuando se inyecte el controlador se mandara a ejecutar la funcion de getPeliculas
  @override
  void onInit() async {
    super.onInit();
    response = await getPeliculas();
  }

  //hacer la peticion
  Future<RequestModel> getPeliculas() async {
    cargando = true;

    final data = await _request.requestGet(host: host, endpoint: endpoint);

    if (data.results.isNotEmpty) {
      listaPeliculas = data.results
          .map((e) => PeliculasModel.fromJson(e))
          .toList();
    }

    cargando = false;

    return data;
  }

  // Getters y setters
  bool get cargando => _cargando.value;
  set cargando(bool value) => _cargando.value = value;

  List<PeliculasModel> get listaPeliculas => _listaPeliculas;
  set listaPeliculas(List<PeliculasModel> peliculas) =>
      _listaPeliculas.assignAll(peliculas);
}
