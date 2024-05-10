import 'package:cloud_firestore/cloud_firestore.dart';

// Hacemos la conexión a la base de datos
FirebaseFirestore db = FirebaseFirestore.instance;

// Función para obtener la lista de productos en tiempo real
Stream<List<Map<String, dynamic>>> getProductos() {
  // Retorna un stream que escucha los cambios en la colección 'productos'
  return db.collection('productos').snapshots().map((snapshot) {
    // Lista para almacenar los productos
    List<Map<String, dynamic>> productos = [];
    // Itera sobre los documentos de la colección
    snapshot.docs.forEach((doc) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      // Verifica si el producto está disponible y lo agrega a la lista
      if (data.containsKey("disponible")) {
        if (data["disponible"] == true) {
          final producto = {
            "uid": doc.id,
            "titulo": data["titulo"],
            "precio": data["precio"],
            "disponible": data["disponible"],
          };
          productos.add(producto);
        }
      }
    });
    return productos;
  });
}

// Guardar titulo en la base de datos
Future<void> addProductos(String titulo, double precio, bool disponible) async {
  await db.collection("productos").add({
    "titulo": titulo,
    "precio": precio,
    "disponible": disponible,
  });
}

// Actualizar titulo en la base de datos
Future<void> updateProductos(String uid, String newtitulo, double newprecio, bool newdisponible) async {
  await db.collection("productos").doc(uid).set({
    "titulo": newtitulo,
    "precio": newprecio,
    "disponible": newdisponible,
  });
}

// Borrar datos de la base de datos
Future<void> deleteProductos(String uid) async{
  await db.collection("productos").doc(uid).delete();
}