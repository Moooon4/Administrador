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
        title: Row(
          children: [
            Image.asset('lib/assets/logotenedorcuchillo.png', scale: 18),
            const SizedBox(
              width: 8,
            ),
            const Text(
              'ADD PRODUCT',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset('lib/assets/camara.png', scale: 8)),
          IconButton(
              onPressed: () {},
              icon: Image.asset('lib/assets/imagen.png', scale: 8))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //----------------------------------------------------------
            // Agregando un campo de texto 'PRODUCTO'
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Ingresar producto',
                  border: InputBorder.none,
                ),
              ),
            ),
            //----------------------------------------------------------
            // Agregando un campo de texto 'PRECIO'
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: precioController,
                decoration: InputDecoration(
                  hintText: 'Ingresar precio',
                  border: InputBorder.none,
                ),
                // Asegurando el ingreso de décimales en el teclado
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
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
