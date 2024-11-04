import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:certamen_2/tabs/marcas_add.dart';
import 'package:certamen_2/tabs/marcas_edit.dart';
import 'package:certamen_2/provider/autos_provider.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  AutosProvider provider = AutosProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: provider.getMarcas(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: snapshot.data.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return Slidable(
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => MarcasEditar(
                            id: snapshot.data[index]['id'],
                            nombre: snapshot.data[index]['nombre'],
                          ),
                        );
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      },
                      icon: Icons.edit,
                      label: 'Editar',
                      backgroundColor: Colors.blue,
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        confirmDialog(context, snapshot.data[index]['nombre'])
                            .then((confirma) {
                          if (confirma) {
                            var nombre = snapshot.data[index]['id'];
                            setState(() {
                              provider
                                  .marcasBorrar(snapshot.data[index]['id'])
                                  .then((borradoExitoso) {
                                if (!borradoExitoso) {
                                  showSnackBar('Ha ocurrido un problema');
                                } else {
                                  showSnackBar('Marca $nombre borrada');
                                  snapshot.data.removeAt(index);
                                }
                              });
                            });
                          }
                        });
                      },
                      icon: Icons.delete,
                      label: 'Borrar',
                      backgroundColor: Colors.red,
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(snapshot.data[index]['nombre']),
                  leading: const Icon(Icons.directions_car),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: Colors.grey[200],
                  onTap: () {},
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const MarcasAgregarDialog(),
          ).then((result) {
            if (result == true) {
              setState(() {});
            }
          });
        },
        icon: const Icon(Icons.add),
        label: const Text('Añadir Marca'),
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context, String marca) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Confirmar borrado'),
          content: Text('¿Borrar la marca $marca?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('CANCELAR'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('ACEPTAR'),
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(mensaje),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black87,
      ),
    );
  }
}
