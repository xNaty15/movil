import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peliculas_practica/components/shared/navigation_controller.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({super.key});
  final NavigationController navController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width * 0.7,
      child: ListView(
        children: [
          DrawerHeader(child: Text('Menu Principal')),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Peliculas'),
            onTap: () {
              navController.changePage(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Series'),
            onTap: () {
              navController.changePage(1);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
