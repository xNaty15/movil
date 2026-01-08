import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_practica/components/movies/models/peliculas_cast_model.dart';

//import 'package:peliculas_/components/utils/constantes.dart';

class PeliculaCastController extends GetxController {
  final _cargando = false.obs; //indica si estás esperando respuesta de la API.
  final _cast = <Cast>[].obs;

  bool get cargando => _cargando.value;
  List<Cast> get cast =>
      _cast; // Lista reactiva → se usa cuando la API devuelve múltiples objetos (una lista de actores)

  Future<void> getCastPelicula(int idPelicula) async {
    try {
      _cargando.value = true;
      _cast.clear();

      final url = Uri.https(
        'api.themoviedb.org',
        '/3/movie/$idPelicula/credits',
        {
          'language': 'es-ES',
          'api_key': '130bfa41bf908ced60b722d2934537f1', // Mi API key
        },
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final castModel = PeliculasCastModel.fromJson(jsonData);
        _cast.addAll(castModel.cast);
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo cargar la información de la película',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _cargando.value = false;
    }
  }
}
