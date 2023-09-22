import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void getAlumnos() async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("tbAlumnos");
    QuerySnapshot mensajes = await collectionReference.get();
    if(mensajes.docs.length != 0){
    for (var doc in mensajes.docs){
    print(doc.data());
    //chatsx.add(doc.data());
    }
  }
}

Future<List> getAlumno() async {
    List datos = [];
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("tbAlumnos");
    QuerySnapshot mensajes = await collectionReference.get();
    if(mensajes.docs.length != 0){
    for (var doc in mensajes.docs){
    print(doc.data());
    datos.add(doc.data());
  }
}
return datos;
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: FutureBuilder(
future: getAlumno(),
builder: ((context, snapshot){
if(snapshot.hasData){
return ListView.builder(
itemCount: snapshot.data?.length,
itemBuilder: ((context, index){
return Text(snapshot.data?[index]["nombres"] + "-" +
snapshot.data?[index]["apellidos"]);
})
);
}else {
return const Center(
child: CircularProgressIndicator(),
);
}
})
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     getAlumnos();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}
