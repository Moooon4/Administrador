import 'package:administrador/services/firebase_service.dart';
import 'package:flutter/material.dart';

class AddNamePage extends StatefulWidget {
  const AddNamePage({super.key});

  @override
  State<AddNamePage> createState() => _AddNamePageState();
}

class _AddNamePageState extends State<AddNamePage> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController precioController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Agregando nombre a la pantalla
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //----------------------------------------------------------
            // Agregando un campo de texto 'PRODUCTO'
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Producto',
              ),
            ),
            //----------------------------------------------------------
            // Agregando un campo de texto 'PRECIO'
            TextField(
              controller: precioController,
              decoration: const InputDecoration(
                hintText: 'Precio',
              ),
              // Asegurando el ingreso de décimales en el teclado
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            //----------------------------------------------------------
            // Agregango el botón para guardar
            ElevatedButton(
                onPressed: () async {
                  try {
                    await addProductos(
                      // Obteniendo los valores de los controladores
                      nameController.text,
                      double.parse(precioController.text),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    // Manejar la excepción de manera adecuada
                    print("Error al guardar el producto: $e");
                    // Mostrar un mensaje de error al usuario
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content:
                            Text("Hubo un problema al guardar el producto."),
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
                },
                child: const Text("Guardar"))
          ],
        ),
      ),
    );
  }
}
