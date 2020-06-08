import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewScreen extends StatefulWidget {
  ReviewScreen({@required this.restId});

  final String restId;

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _review(),
              Container(
                height: 60,
                child: buildStreamBuilder(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot> buildStreamBuilder() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('restReviews')
          .document(widget.restId)
          .collection('review')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.documents.isEmpty) {
          return Text('No reviews yet');
        }
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            return _buildListItem(context, snapshot.data.documents[index]);
          },
        );
      },
    );
  }

  Widget _buildListItem(context, document) {
    return Container(
      child: Text(document['review']),
    );
  }

  Widget _review() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: TextFormField(
        decoration: InputDecoration(hintText: 'Leave your review'),
        onFieldSubmitted: (text) async {
          final _firestoreReview = Firestore.instance
              .collection('restReviews')
              .document(widget.restId)
              .collection('review');

          var timestamp = DateTime.now();
          var toSend = {'timestamp': timestamp, 'review': text};

          await _firestoreReview.add(toSend);
          setState(() {});
        },
      ),
    );
  }
}