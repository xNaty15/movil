import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:peliculas_practica/components/movies/views/peliculas_view.dart';
import 'package:peliculas_practica/components/series/views/series_view.dart';
import 'package:peliculas_practica/components/shared/menu_drawer.dart';
import 'package:peliculas_practica/components/shared/navigation_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final NavigationController navController = Get.put(NavigationController());

  final List<Widget> paginas = [
    PeliculasView(), //0
    SeriesView(), // 1
    Text('Hola Naty'),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            [
              'Peliculas',
              'Series',
              'Proxima Sección',
            ][navController.selectedIndex.value],
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey,
        ),
        body: paginas[navController.selectedIndex.value],

        drawer: MenuDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          currentIndex: navController.selectedIndex.value,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Peliculas',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Series'),
            BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'SECCION'),
          ],
          onTap: navController.changePage,
        ),
      ),
    );
  }
}
