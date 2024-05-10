import 'package:administrador/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Agregando título al HOME
        title: Row(
          children: [
            Image.asset('lib/assets/logotenedorcuchillo.png', scale: 16),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'ADMIN',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            ),
          ],
        ),
      ),
      // Comienza el llamado de datos desde la base de datos
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: getProductos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                 // Listando los productos
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Builder(builder: (context) {
                    // Agregando apartado para eliminar producto
                    // Propiedad onDismissed
                    return Dismissible(
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
                                  TextButton(
                                      onPressed: () {
                                        return Navigator.pop(
                                          context,
                                          false,
                                        );
                                      },
                                      // Agregando el color de la opción de eliminado
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
                                      // Agregando el color de la opción de eliminado
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
                      /*---------------------Agregando box------------------------------*/
                      // Agregando el diseño del box
                      child: Container(
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        // Agregando el child para el llamado al listado por ID/uid
                        child: Row(
                          children: [
                             // Espacio para agregar la foto
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage('lib/assets/pupusas1.jpg'),
                                  //image: NetworkImage(snapshot.data?[index]['foto']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Espacio entre la imagen y el ListTile
                            const SizedBox(width: 10),
                            Expanded(
                              child: ListTile(
                                // Agregando el título del producto
                                title: Text(
                                  snapshot.data?[index]['titulo'] ?? '',
                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20)
                                ),
                                // Agregando el subtítulo del producto o sea, el precio
                                // y también, con el ".toStringAsFixed(2)" se muestra el precio con dos decimales
                                //title: Text("¿Está seguro de eliminar el producto: ${snapshot.data?[index]['titulo']}?"),
                                subtitle: Text(
                                  snapshot.data?[index]['precio'] != null
                                      ? '\$${snapshot.data?[index]['precio']}'
                                      : '',
                                  style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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
                                          "precio": snapshot.data?[index]['precio'] ?? 0.0,
                                        });
                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
            } else {
              // Agregando un mensaje de cargando los productos al HOME
              return const Center(child: Text("Cargando..."));
            }
          }),
      // Agregando el botón flotante para agregar productos
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: Image.asset('lib/assets/agregar.png', scale: 8, color: Colors.white.withOpacity(0.8),),
        backgroundColor: Colors.black.withOpacity(0.6),
      ),
    );
  }
}