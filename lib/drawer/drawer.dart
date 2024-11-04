import 'package:flutter/material.dart';
import 'package:certamen_2/about.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                      'assets/profile.jpeg'), // Asegúrate de que la imagen esté en esta ruta
                ),
                const SizedBox(height: 8),
                const Text(
                  'Marcelo Mejías',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Acerca de'),
            onTap: () {
              // Navega a la pantalla de Acerca de
              MaterialPageRoute(builder: (context) => const AboutScreen());
            },
          ),
        ],
      ),
    );
  }
}
