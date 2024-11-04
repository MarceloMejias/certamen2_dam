import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AutosProvider {
  final String apiURL = 'http://127.0.0.1:8000/api';

  // Obtener marcas
  Future<List<dynamic>> getMarcas() async {
    var uri = Uri.parse('$apiURL/marcas');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  // Agregar marcas
  Future<bool> marcasAgregar(String nombreMarca) async {
    var uri = Uri.parse('$apiURL/marcas');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{'nombre': nombreMarca}),
    );

    if (respuesta.statusCode == 201) {
      return true; // Devuelve true si la creación fue exitosa (201 Created)
    } else {
      print('Error al agregar marca: ${respuesta.body}'); // Registra el error
      return false;
    }
  }

  // Editar marcas
  Future<LinkedHashMap<String, dynamic>> marcasEditar(
      int id, String nombreMarca) async {
    var uri = Uri.parse('$apiURL/marcas/$id');
    var respuesta = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{'nombre': nombreMarca}),
    );
    return json.decode(respuesta.body);
  }

  // Borrar marcas
  Future<bool> marcasBorrar(int id) async {
    var uri = Uri.parse('$apiURL/marcas/$id');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  // Obtener autos
  Future<List<dynamic>> getAutos() async {
    var uri = Uri.parse('$apiURL/autos');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  // Agregar autos
  Future<bool> autosAgregar(
      String patente, String modelo, double precio, int marcaId) async {
    var uri = Uri.parse('$apiURL/autos');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, dynamic>{
        'patente': patente,
        'modelo': modelo,
        'precio': precio,
        'marca_id': marcaId
      }),
    );

    if (respuesta.statusCode == 201) {
      return true; // Devuelve true si la creación fue exitosa (201 Created)
    } else {
      print('Error al agregar auto: ${respuesta.body}'); // Registra el error
      return false;
    }
  }

  // Editar autos
  Future<LinkedHashMap<String, dynamic>> autosEditar(
      int id, String patente, String modelo, double precio, int marcaId) async {
    var uri = Uri.parse('$apiURL/autos/$id');
    var respuesta = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, dynamic>{
        'patente': patente,
        'modelo': modelo,
        'precio': precio,
        'marca_id': marcaId
      }),
    );
    return json.decode(respuesta.body);
  }
}
