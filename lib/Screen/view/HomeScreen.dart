import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Screen/model/HomeModel.dart';
import 'package:firebase/firebase/firebase.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List alldata = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                insertdata();
              },
              child: Text("click")),
          Expanded(
            child: StreamBuilder(
                stream: readdata(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.hasError}");
                  } else if (snapshot.hasData) {
                    var docList = snapshot.data!.docs;
                    alldata.clear();

                    for (QueryDocumentSnapshot x in docList) {
                      var finaldata = x.data() as Map<String, dynamic>;
                      Model m1 = Model(
                          id: finaldata['id'],
                          name: finaldata['name'],
                          mobile: finaldata['mobile'],
                          key: x.id);
                      alldata.add(m1);
                    }

                    return ListView.builder(
                        itemCount: alldata.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("${alldata[index].name}"),
                            trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  deleteData("${alldata[index].key}");
                                }),
                          );
                        });
                  }

                  return Center(child: CircularProgressIndicator());
                }),
          )
        ],
      ),
    ));
  }
}
