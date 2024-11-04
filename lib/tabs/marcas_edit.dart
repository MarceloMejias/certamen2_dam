import 'package:flutter/material.dart';
import 'package:certamen_2/provider/autos_provider.dart';

class MarcasEditar extends StatefulWidget {
  final int id;
  final String nombre;

  const MarcasEditar({super.key, required this.id, required this.nombre});

  @override
  State<MarcasEditar> createState() => _MarcasEditarState();
}

class _MarcasEditarState extends State<MarcasEditar> {
  late TextEditingController nombreCtrl;

  @override
  void initState() {
    super.initState();
    nombreCtrl = TextEditingController(
        text: widget.nombre); // Inicializa con el nombre actual
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Marca'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nombreCtrl,
              decoration: InputDecoration(
                labelText: 'Marca Autos',
                hintText: 'Nuevo nombre del fabricante',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  AutosProvider provider = AutosProvider();
                  provider
                      .marcasEditar(widget.id, nombreCtrl.text)
                      .then((dynamic exito) {
                    if (exito as bool) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Marca actualizada con éxito')),
                      );
                      Navigator.pop(
                          context, true); // Devuelve true al actualizar
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Error al actualizar la marca')),
                      );
                    }
                  });
                },
                child: const Text('Guardar Cambios'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
