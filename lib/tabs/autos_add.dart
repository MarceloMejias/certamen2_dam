import 'package:flutter/material.dart';
import 'package:certamen_2/provider/autos_provider.dart';

class AutosAgregarDialog extends StatefulWidget {
  const AutosAgregarDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const AutosAgregarDialog(),
    );
  }

  @override
  State<AutosAgregarDialog> createState() => _AutosAgregarDialogState();
}

class _AutosAgregarDialogState extends State<AutosAgregarDialog> {
  final TextEditingController patenteCtrl = TextEditingController();
  final TextEditingController modeloCtrl = TextEditingController();
  final TextEditingController precioCtrl = TextEditingController();
  String? selectedMarca;

  final List<Map<String, dynamic>> marcas = [
    {'id': 1, 'nombre': 'Toyota'},
    {'id': 2, 'nombre': 'Honda'},
    {'id': 3, 'nombre': 'Ford'},
    {'id': 4, 'nombre': 'Chevrolet'},
    {'id': 5, 'nombre': 'Nissan'},
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Auto'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: patenteCtrl,
              decoration: const InputDecoration(
                labelText: 'Patente',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: modeloCtrl,
              decoration: const InputDecoration(
                labelText: 'Modelo',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: precioCtrl,
              decoration: const InputDecoration(
                labelText: 'Precio',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedMarca,
              hint: const Text('Selecciona una Marca'),
              items: marcas.map((marca) {
                return DropdownMenuItem<String>(
                  value: marca['id'].toString(),
                  child: Text(marca['nombre']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMarca = value;
                });
              },
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            final provider = AutosProvider();
            await provider.autosAgregar(
              patenteCtrl.text,
              modeloCtrl.text,
              double.tryParse(precioCtrl.text) ?? 0,
              int.tryParse(selectedMarca ?? '') ?? 0,
            );
            Navigator.pop(context, true); // Cierra el diálogo y retorna true
          },
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}
