import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/widgets/loading_builder.dart';

import 'admin_add_item_screen.dart';
import 'bloc/admin_bloc.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: ColorsUtils.textBlack,
        elevation: 0,
        centerTitle: true,
        title: const Text("Admin Panel"),
        leading: const BackButton(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => AdminBloc(),
                            child: AdminAddItemScreen(),
                          )));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("products").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingBuilder().commonCircularLoading();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Dismissible(
                behavior: HitTestBehavior.translucent,
                direction: DismissDirection.endToStart,
                crossAxisEndOffset: 0.1,
                background: Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                key: ValueKey<int>(index),
                child: Column(
                  children: [
                    ListTile(
                      leading: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Image.network(
                              "${snapshot.data!.docs[index]["imgUrl"].toString()}")),
                      title:
                          Text(snapshot.data!.docs[index]["name"].toString()),
                      subtitle: Text(
                          "\$${snapshot.data!.docs[index]["price"].toString()}"),
                      trailing: const Icon(
                        Icons.delete,
                        color: ColorsUtils.red,
                      ),
                    ),
                    Divider()
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
