// This is your data access object (DAO) for your messages.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'message.dart';

class MessageDao {
  // Gets an instance of FirebaseFirestore and then gets
  // the root of the messages collection by calling collection().
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('messages');

  // Now, you need MessageDao to perform two functions:
  // saving and retrieving.

  // TODO: Add saveMessage
  // This function takes a Message as a parameter and uses your
  // CollectionReference to save the JSON message to your Cloud Firestore:
  void saveMessage(Message message) {
    // toJson() converts the message to a JSON string.
    // add() Adds the string to the collection.
    collection.add(message.toJson());
  }

  // TODO: Add getMessageStream
  // This returns a stream of data at the root level.
  Stream<QuerySnapshot> getMessageStream() {
    return collection.snapshots();
  }
}
