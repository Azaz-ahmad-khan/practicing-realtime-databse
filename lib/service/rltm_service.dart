import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:reltm_crud/models/item.dart';

class RltmService {
  final instance = FirebaseDatabase.instance;
  Future<String> addPost(Item item) async {
    try {
      final ref = instance.ref('items').push();
      final String generatedId = ref.key!;
      final Map<String, dynamic> itemData = item.toMap();
      itemData['id'] = generatedId;

      await ref.set(itemData);
      return generatedId;
    } on FirebaseException catch (e) {
      throw Exception('Error : $e');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<List<Item>> getItemsRealtime() {
    return instance.ref('items').onValue.map((event) {
      final snapshot = event.snapshot;
      if (snapshot.exists) {
        return snapshot.children.map((element) {
          final Map<String, dynamic> valueMap = Map<String, dynamic>.from(
            element.value as Map,
          );
          return Item.fromMap(valueMap);
        }).toList();
      }
      return [];
    });
  }
}
