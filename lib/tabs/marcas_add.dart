import 'package:flutter/material.dart';
import 'package:certamen_2/provider/autos_provider.dart';

class MarcasAgregarDialog extends StatefulWidget {
  const MarcasAgregarDialog({super.key});

  @override
  State<MarcasAgregarDialog> createState() => _MarcasAgregarDialogState();
}

class _MarcasAgregarDialogState extends State<MarcasAgregarDialog> {
  final TextEditingController nombreMarcaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Marca'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nombreMarcaCtrl,
            decoration: const InputDecoration(
              labelText: 'Nombre de la Marca',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.pop(context, false), // Cierra el diálogo sin agregar
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            AutosProvider provider = AutosProvider();
            bool result = await provider.marcasAgregar(nombreMarcaCtrl.text);
            if (result) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Marca agregada con éxito')),
              );
              Navigator.pop(context, true); // Devuelve true al agregar
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error al agregar la marca')),
              );
            }
          },
          child: const Text('Agregar Marca'),
        ),
      ],
    );
  }
}
