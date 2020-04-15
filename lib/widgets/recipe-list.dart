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
        trailing: Text((document['views'] ?? 0).toString()),
      ),
      onTap: () {
        Firestore.instance.runTransaction((transaction) async {
          DocumentSnapshot freshSnap = await transaction.get(document.reference);
          await transaction.update(freshSnap.reference, {
            'views': (freshSnap['views'] ?? 0) + 1
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
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) => _buildListItem(snapshot.data.documents[index]),
        );
      },
    );
  }
}