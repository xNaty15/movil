import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_practica/components/movies/models/peliculas_detalle_model.dart';
import 'package:peliculas_practica/components/utils/constantes.dart';

class PeliculaDetalleController extends GetxController {
  final _cargando = false.obs;
  final _detallePelicula = Rxn<PeliculaDetalleModel>();
  // Rxn → variable reactiva que puede ser null, se usa cuando la API puede no devolver datos

  bool get cargando => _cargando.value;
  PeliculaDetalleModel? get detallePelicula => _detallePelicula.value;

  Future<void> getDetallePelicula(int idPelicula) async {
    try {
      _cargando.value = true;
      _detallePelicula.value = null;

      final url = Uri.https('api.themoviedb.org', '/3/movie/$idPelicula', {
        'language': 'es-ES',
        'api_key': '130bfa41bf908ced60b722d2934537f1', // Mi API key
      });

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _detallePelicula.value = PeliculaDetalleModel.fromJson(jsonData);
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      _detallePelicula.value = null;
      Get.snackbar(
        'Error',
        'No se pudo cargar la información de la película',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      _cargando.value = false;
    }
  }
}
