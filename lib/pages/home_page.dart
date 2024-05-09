import 'package:administrador/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Agregando título a la
        title: const Text('HOME PAGE'),
      ),
      // Comienza el llamado de datos desde la base de datos
      body: FutureBuilder(
          future: getProductos(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                // Listando los productos
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Builder(builder: (context) {
                    // Agregando apartado para eliminar producto
                    return Dismissible(
                      // Propiedad onDismissed
                      onDismissed: (direction) async {
                        // Eliminando desde la bd desde el ID/uid
                        await deleteProductos(snapshot.data?[index]['uid']);
                        // Validando el array eliminado
                        snapshot.data?.removeAt(index);
                      },
                      // Validando la confirmación de la dirección de eliminado
                      confirmDismiss: (direction) async {
                        // Validando la dirección de eliminado
                        bool result = true;
                        result = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                // Agregando la opción de eliminado pero, se muestra el nombre del producto (titulo)
                                title: Text(
                                    "¿Está seguro de eliminar el producto: ${snapshot.data?[index]['titulo']}?"),
                                // Agregando las opciones de eliminado
                                actions: [
                                  // Botón de cancelar
                                  TextButton(
                                      onPressed: () {
                                        return Navigator.pop(
                                          context,
                                          false,
                                        );
                                      },
                                      // Agregando el texto con color
                                      child: const Text("Cancelar",
                                          style: TextStyle(color: Colors.red))),
                                  // Botón de aceptar
                                  TextButton(
                                      onPressed: () {
                                        return Navigator.pop(
                                          context,
                                          true,
                                        );
                                      },
                                      // Agregando el texto con color
                                      child: const Text("Sí, estoy seguro",
                                          style:
                                              TextStyle(color: Colors.green)))
                                ],
                              );
                            });
                        return result;
                      },
                      // Agregando color e icono al fondo para eliminar
                      background: Container(
                        color: Colors.red,
                        child: const Icon(Icons.delete),
                      ),
                      // Agregando la dirección para eliminar (de derecha a izaquiera)
                      direction: DismissDirection.startToEnd,
                      // Agregando función de eliminado por selección
                      key: Key(snapshot.data?[index]['uid']),
                      // Agregando el child para el llamado al listado por ID/uid
                      child: ListTile(
                          // Agregando el título del producto
                          title: Text(
                            snapshot.data?[index]['titulo'] ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          // Agregando el subtítulo del producto o sea, el precio
                          // y también, con el ".toStringAsFixed(2)" se muestra el precio con dos decimales
                          //title: Text("¿Está seguro de eliminar el producto: ${snapshot.data?[index]['titulo']}?"),
                          subtitle: Text(
                            snapshot.data?[index]['precio'] != null
                                ? '\$${snapshot.data?[index]['precio']}'
                                : '',
                            style: TextStyle(fontSize: 12),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 50),
                          onTap: () async {
                            // Validamos que snapshot.data no sea nulo y que el index esté en rango válido de más 3
                            if (snapshot.data != null &&
                                index >= 0 &&
                                index < snapshot.data!.length) {
                              // Espera los datos modificados y los muestra ya editados
                              await Navigator.pushNamed(context, '/edit',
                                  arguments: {
                                    /*
                            Llamado de productos desde la bd para el HOME para realizar
                            las modificaciones pero también, mostrarlos al administrador.
                            */
                                    "uid": snapshot.data?[index]['uid'],
                                    "titulo": snapshot.data?[index]['titulo'],
                                    "precio": snapshot.data?[index]['precio']?? 0.0,
                                  });
                              setState(() {});
                            }
                          }),
                    );
                  });
                },
              );
            } else {
              // Agregando un mensaje de cargando los productos al HOME
              return const Center(child: Text("Cargando..."));
            }
          })),
      // Agregando el botón flotante para agregar productos
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
