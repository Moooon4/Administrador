import 'package:administrador/services/firebase_service.dart';
import 'package:flutter/material.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({super.key});

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController precioController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    // Asignar cadena vacía si el valor es nulo
    nameController.text = arguments?['titulo'] ?? '';
    // Convertir a cadena y asignar cadena vacía si el valor es nulo
    precioController.text = arguments?['precio']?.toString() ?? '';

    return Scaffold(
      appBar: AppBar(
        // Agregando nombre a la pantalla
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //----------------------------------------------------------
            // Agregando un campo de texto para modificar 'PRODUCTO'
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingrese la modificación',
              ),
            ),
            //----------------------------------------------------------
            // Agregando un campo de texto para modificar 'PRECIO'
            TextField(
              controller: precioController,
              decoration: const InputDecoration(
                hintText: 'Ingrese la modificación',
              ),
            ),
            //----------------------------------------------------------
            // Agregango el botón para actualizar
            ElevatedButton(
              onPressed: () async {
                if (arguments != null) {
                  try {
                    await updateProductos(
                      // Obteniendo el valor de 'uid'
                      arguments['uid'],
                      // Obteniendo los valores de los controladores
                      nameController.text,
                      double.parse(precioController.text),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    // Manejar la excepción de manera adecuada
                    print("Error al actualizar el producto: $e");
                    // Puedes mostrar un mensaje de error al usuario
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content:
                            Text("Hubo un problema al actualizar el producto."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Aceptar"),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              child: const Text("Actualizar"),
            )
          ],
        ),
      ),
    );
  }
}
