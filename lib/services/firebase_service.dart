import 'package:cloud_firestore/cloud_firestore.dart';

// Hacemos la conexión a la base de datos
FirebaseFirestore db = FirebaseFirestore.instance;

// Promesa de lista
Future<List>getProductos() async{
  // 1.- Llamamos la información de FireStore
  List productos = [];

  // 2.- Obtener un documento por su id (pocos registros)
  QuerySnapshot queryProductos = await db.collection('productos').get();
  
  for (var doc in queryProductos.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    final producto ={
      "titulo": data["titulo"],
      "uid": doc.id,
    };

    // producto tiene la propiedad titulo
    productos.add(producto);
  }

  return productos;
}

// Guardar titulo en la base de datos
Future<void> addProductos(String titulo) async {
  await db.collection("productos").add({"titulo": titulo});
}

// Actualizar titulo en la base de datos
Future<void> updateProductos(String uid, String newtitulo) async {
  await db.collection("productos").doc(uid).set({"titulo": newtitulo});
}

// Borrar datos de la base de datos
Future<void> deleteProductos(String uid) async{
  await db.collection("productos").doc(uid).delete();
}