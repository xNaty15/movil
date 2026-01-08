import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peliculas_practica/components/movies/controllers/pelicula_cast_controller.dart';
import 'package:peliculas_practica/components/movies/controllers/pelicula_detalle_controller.dart';
import 'package:peliculas_practica/components/movies/models/peliculas_detalle_model.dart';
import 'package:peliculas_practica/components/movies/views/lista_actores.dart';

class PeliculaDetalleView extends StatelessWidget {
  final int idPelicula;
  //f
  const PeliculaDetalleView({super.key, required this.idPelicula});

  @override
  Widget build(BuildContext context) {
    //return GetBuilder<PeliculaDetalleController>(
    //init: PeliculaDetalleController(),
    return GetBuilder<PeliculaDetalleController>(
      init: PeliculaDetalleController(),

      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const Text('Detalles de la Película')),
          body: _PeliculaDetalleContent(
            idPelicula: idPelicula,
            controller: controller,
          ),
        );
      },
    );
  }
}

class _PeliculaDetalleContent extends StatefulWidget {
  final int idPelicula;
  final PeliculaDetalleController controller;

  const _PeliculaDetalleContent({
    required this.idPelicula,
    required this.controller,
  });

  @override
  State<_PeliculaDetalleContent> createState() =>
      _PeliculaDetalleContentState();
}

class _PeliculaDetalleContentState extends State<_PeliculaDetalleContent> {
  @override
  void initState() {
    super.initState();
    _cargarDetalle();
  }

  void _cargarDetalle() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.getDetallePelicula(widget.idPelicula);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = widget.controller;
      if (controller.cargando) {
        return const Center(child: CircularProgressIndicator());
      }
      final detalle = controller.detallePelicula;
      if (detalle == null) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'No se pudo cargar la información',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _cargarDetalle,
                child: const Text('Reintentar'),
              ),
            ],
          ),
        );
      }
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster principal
            _buildPoster(detalle),
            // Información principal
            _buildInfoPrincipal(detalle),
            // Sinopsis
            _buildSinopsis(detalle),
            // Información adicional
            _buildInfoAdicional(detalle),
            // Géneros
            _buildGeneros(detalle),
            // Información tecnica
            _buildInfoTecnica(detalle),
          ],
        ),
      );
    });
  }

  Widget _buildPoster(PeliculaDetalleModel detalle) {
    return Container(
      width: double.infinity,
      height: 400,
      child: Stack(
        children: [
          // Imagen de fondo
          if (detalle.backdropPath.isNotEmpty)
            Image.network(
              'https://image.tmdb.org/t/p/w780${detalle.backdropPath}',
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
            ),
          // Poster que se pone encima del poster de atras
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              height: 200,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${detalle.posterPath}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoPrincipal(PeliculaDetalleModel detalle) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titulo
          Text(
            detalle.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          // Titulo original
          if (detalle.originalTitle != detalle.title)
            Text(
              detalle.originalTitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          const SizedBox(height: 16),
          // Información general
          Row(
            children: [
              // Año
              _buildInfoChip(
                Icons.calendar_today,
                detalle.releaseDate.year.toString(),
              ),
              const SizedBox(width: 12),
              // Duración
              _buildInfoChip(Icons.schedule, '${detalle.runtime} min'),
              const SizedBox(width: 12),
              // Rating
              _buildInfoChip(
                Icons.star,
                detalle.voteAverage.toStringAsFixed(1),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (detalle.tagline.isNotEmpty)
            Text(
              '"${detalle.tagline}"',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.blue[700]),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSinopsis(PeliculaDetalleModel detalle) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sinopsis',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            detalle.overview.isNotEmpty
                ? detalle.overview
                : 'No hay sinopsis disponible.',
            style: const TextStyle(fontSize: 16, height: 1.6),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGeneros(PeliculaDetalleModel detalle) {
    if (detalle.genres.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Géneros',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: detalle.genres
                .map(
                  (genre) => Chip(
                    label: Text(genre.name),
                    backgroundColor: Colors.blue[100],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoAdicional(PeliculaDetalleModel detalle) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Información Adicional',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Estado', detalle.status),
          _buildInfoRow(
            'Idioma Original',
            detalle.originalLanguage.toUpperCase(),
          ),
          _buildInfoRow('Popularidad', detalle.popularity.toStringAsFixed(1)),
          if (detalle.budget > 0)
            _buildInfoRow('Presupuesto', '\$${detalle.budget.toString()}'),
          if (detalle.revenue > 0)
            _buildInfoRow('Ingresos', '\$${detalle.revenue.toString()}'),
        ],
      ),
    );
  }

  Widget _buildInfoTecnica(PeliculaDetalleModel detalle) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Información Técnica',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            'Página Web',
            detalle.homepage.isNotEmpty ? 'Disponible' : 'No disponible',
          ),
          _buildInfoRow('ID de IMDB', detalle.imdbId),
          _buildInfoRow('Votos', detalle.voteCount.toString()),
          _buildInfoRow('Es para adultos', detalle.adult ? 'Sí' : 'No'),

          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final castController = Get.put(PeliculaCastController());
                await castController.getCastPelicula(detalle.id);
                Get.to(() => ListaActoresPage());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Ver actores"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$titulo:',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          Expanded(child: Text(valor, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
