// Libs
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeList extends StatelessWidget {

  Widget _buildListItem(DocumentSnapshot document) {
    return InkWell(
      child: ListTile(
        leading: Container(
          width: 80.0,
          child: Image.network(
            document['imageUrl'],
            fit: BoxFit.fitWidth
          ),
        ),
        title: Text(document['name']),
        subtitle: Text('${document['prepTime']}mins prep, ${document['cookTime']}mins cook'),
        trailing: Text(document['views'].toString()),
      ),
      onTap: () {
        Firestore.instance.runTransaction((transaction) async {
          DocumentSnapshot freshSnap = await transaction.get(document.reference);
          await transaction.update(freshSnap.reference, {
            'views': freshSnap['views'] + 1
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('recipes').orderBy('name').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          itemExtent: 80.0,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) => _buildListItem(snapshot.data.documents[index]),
        );
      },
    );
  }
}