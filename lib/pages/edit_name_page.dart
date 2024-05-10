import 'package:administrador/services/firebase_service.dart';
import 'package:flutter/material.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({Key? key});

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController precioController = TextEditingController(text: "");
  bool disponible = true;
  
  @override
  Widget build(BuildContext context) {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    // Asignar cadena vacía si el valor es nulo
    nameController.text = arguments?['titulo'] ?? '';
    // Convertir a cadena y asignar cadena vacía si el valor es nulo
    precioController.text = arguments?['precio']?.toString() ?? '';
    
    // Asignar valor de 'disponible' si el valor es nulo PERO
    // Sí, se agregad de:
    // disponible = arguments?['disponible'] ?? true;
    // Solo se mostrará true o false, no se podrá cambiar

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
              'EDIT PRODUCT',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //----------------------------------------------------------
            // Agregando un campo de texto para modificar 'PRODUCTO'
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Ingrese la modificación',
                ),
              ),
            ),
            //----------------------------------------------------------
            // Agregando un campo de texto para modificar 'PRECIO'
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: precioController,
                decoration: const InputDecoration(
                  hintText: 'Ingrese la modificación',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            //----------------------------------------------------------
            // Agregando un switch para modificar 'DISPONIBILIDAD'
            SwitchListTile(
              title: const Text('Disponible'),
              value: disponible,
              onChanged: (value) {
                setState(() {
                  disponible = value;
                });
              },
            ),
            //----------------------------------------------------------
            // Agregango el botón para actualizar
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    precioController.text.isNotEmpty) {
                  if (arguments != null) {
                    try {
                      await updateProductos(
                        // Obteniendo el valor de 'uid'
                        arguments['uid'],
                        // Obteniendo los valores de los controladores
                        nameController.text,
                        double.parse(precioController.text),
                        disponible,
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      // Manejar la excepción de manera adecuada
                      print("Error al actualizar el producto: $e");
                      // Mostrar un mensaje de error al usuario
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(
                              "Hubo un problema al actualizar el producto."),
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
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error"),
                      content: Text("Todos los campos son obligatorios."),
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
              child: const Text("Actualizar"),
            )
          ],
        ),
      ),
    );
  }
}