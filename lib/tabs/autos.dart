import 'package:flutter/material.dart';
import 'package:certamen_2/provider/autos_provider.dart';
import 'autos_add.dart'; // Asegúrate de que el nombre del archivo es correcto

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  final AutosProvider provider = AutosProvider();
  List<dynamic> autos = [];

  @override
  void initState() {
    super.initState();
    _fetchAutos();
  }

  Future<void> _fetchAutos() async {
    final response = await provider.getAutos();
    setState(() {
      autos = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: autos.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final auto = autos[index];
            return ListTile(
              title: Text(auto['modelo']),
              subtitle: Text(
                  'Patente: ${auto['patente']} - Precio: \$${auto['precio']}'),
              trailing: Text(auto['marca']['nombre']),
              onTap: () {
                // Acción al presionar un auto en la lista
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const AutosAgregarDialog(),
          ).then((result) {
            if (result == true) {
              _fetchAutos(); // Refresca la lista después de agregar un auto
            }
          });
        },
        icon: const Icon(Icons.add),
        label: const Text('Agregar Auto'),
      ),
    );
  }
}
