
import 'package:cloud_firestore/cloud_firestore.dart';

class GarageFirebase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createSpots({
    required String garageId,
    required String levelId,
    required int spaces,
  }) async {
    final spotsRef = firestore
        .collection('garages')
        .doc(garageId)
        .collection('levels')
        .doc(levelId)
        .collection('spots');

    final existingSpots = await spotsRef.limit(1).get();

    if (existingSpots.docs.isNotEmpty) {
      return;
    }

    for (int i = 1; i <= spaces; i++) {
      await spotsRef.doc('spot$i').set({
        'number': i,
        'status': 'available',
      });
    }
  }

  Future<void> createLevels({
    required String garageId,
    required int spotsPerLevel,
  }) async {
    final levelsRef = firestore
        .collection('garages')
        .doc(garageId)
        .collection('levels');

    for (int i = 1; i <= 3; i++) {
      final levelId = 'level$i';

      final levelDoc = await levelsRef.doc(levelId).get();

      if (!levelDoc.exists) {
        await levelsRef.doc(levelId).set({
          'level': 'Level $i',
          'spaces': spotsPerLevel,
          'price': 30,
        });
      }

      await createSpots(
        garageId: garageId,
        levelId: levelId,
        spaces: spotsPerLevel,
      );
    }
  }
}
