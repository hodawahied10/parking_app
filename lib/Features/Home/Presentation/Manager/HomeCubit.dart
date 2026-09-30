
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parkingapp/Features/Home/data/model/GarageModel.dart';
import 'package:parkingapp/Features/Home/data/model/ParkingLevel.dart';
import 'package:parkingapp/Features/Home/data/model/ParkingSpot.dart';

import 'package:parkingapp/Features/Home/Data/HomeHive.dart';
import 'package:parkingapp/Features/Home/Presentation/Manager/HomeState.dart';
import 'package:parkingapp/Features/Home/data/data_source/GarageFirebase.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final HomeHive homeHive = HomeHive();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GarageFirebase garageFirebase = GarageFirebase();

  List<GarageModel> allGarages = [];

  DocumentSnapshot? lastDocument;

  bool hasMore = true;

  bool isLoadingMore = false;

  static const int pageSize = 10;

  Future<void> _initializeGarageData(String garageId) async {
    await garageFirebase.createLevels(
      garageId: garageId,
      spotsPerLevel: 20,
    );
  }

  Future<List<ParkingSpot>> _getSpots({
    required String garageId,
    required String levelId,
  }) async {
    final snapshot = await firestore
        .collection('garages')
        .doc(garageId)
        .collection('levels')
        .doc(levelId)
        .collection('spots')
        .get();

    return snapshot.docs.map((doc) {
      return ParkingSpot.fromJson(doc.data());
    }).toList();
  }

  Future<List<ParkingLevel>> _getLevels(String garageId) async {
    final levelsSnapshot = await firestore
        .collection('garages')
        .doc(garageId)
        .collection('levels')
        .get();

    final levels = <ParkingLevel>[];

    for (final levelDoc in levelsSnapshot.docs) {
      final levelData = levelDoc.data();

      final spots = await _getSpots(
        garageId: garageId,
        levelId: levelDoc.id,
      );

      final level = ParkingLevel(
        level: levelData['level']?.toString() ?? 'Unknown',
        spaces: (levelData['spaces'] ?? 0) as int,
        price: (levelData['price'] ?? 0).toDouble(),
        spots: spots,
      );

      levels.add(level);
    }

    return levels;
  }

  Future<GarageModel> _getGarage(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) async {
    await _initializeGarageData(doc.id);

    final garageData = doc.data() ?? {};

    final levels = await _getLevels(doc.id);

    return GarageModel(
      id: doc.id,
      name: garageData['name']?.toString() ?? 'Unknown',
      location: garageData['location']?.toString() ?? 'Unknown',
      image: garageData['image']?.toString() ?? 'Unknown',
      levels: levels,
      pricePerHour:
          (garageData['pricePerHour'] ?? 0).toDouble(),
    );
  }

  Future<void> getGarages() async {
    print('=== getGarages CALLED ===');

    if (isClosed) return;

    emit(HomeLoading());

    try {
      final cachedGarages = await homeHive.getGarages();

      print('=== CACHED: ${cachedGarages.length} ===');

      if (isClosed) return;

      if (cachedGarages.isNotEmpty) {
        allGarages = cachedGarages;

        emit(HomeSuccess(garages: allGarages));
      }

      final snapshot = await firestore
          .collection('garages')
          .limit(pageSize)
          .get();

      if (isClosed) return;

      print(
        '=== FIRESTORE DOCS: ${snapshot.docs.length} ===',
      );

      for (final doc in snapshot.docs) {
        print('FIRESTORE GARAGE ID: ${doc.id}');
        print('FIRESTORE DATA: ${doc.data()}');
      }

      if (snapshot.docs.isNotEmpty) {
        lastDocument = snapshot.docs.last;
      }

      if (snapshot.docs.length < pageSize) {
        hasMore = false;
      }

      final garages = <GarageModel>[];

      for (final doc in snapshot.docs) {
        final garage = await _getGarage(doc);

        if (isClosed) return;

        print('GARAGE ID: ${garage.id}');
        print('NAME: ${garage.name}');
        print('LOCATION: ${garage.location}');
        print('IMAGE: ${garage.image}');
        print('LEVELS: ${garage.levels.length}');

        for (final level in garage.levels) {
          print(
            '${level.level} -> ${level.spots.length} spots',
          );
        }

        garages.add(garage);
      }

      if (isClosed) return;

      allGarages = garages;

      await homeHive.saveGarages(garages);

      if (isClosed) return;

      emit(HomeSuccess(garages: allGarages));

      print(
        '=== SUCCESS EMITTED with ${garages.length} garages ===',
      );
    } catch (e) {
      print('=== HOME ERROR: $e ===');

      if (isClosed) return;

      final cachedGarages = await homeHive.getGarages();

      if (isClosed) return;

      if (cachedGarages.isNotEmpty) {
        allGarages = cachedGarages;

        emit(HomeSuccess(garages: cachedGarages));
      } else {
        emit(HomeError(message: e.toString()));
      }
    }
  }

  Future<void> loadMoreGarages() async {
    if (!hasMore || isLoadingMore || lastDocument == null) {
      return;
    }

    if (isClosed) return;

    isLoadingMore = true;

    try {
      final snapshot = await firestore
          .collection('garages')
          .startAfterDocument(lastDocument!)
          .limit(pageSize)
          .get();

      if (isClosed) return;

      print(
        '=== LOAD MORE: ${snapshot.docs.length} garages ===',
      );

      if (snapshot.docs.isNotEmpty) {
        lastDocument = snapshot.docs.last;
      }

      if (snapshot.docs.length < pageSize) {
        hasMore = false;
      }

      final newGarages = <GarageModel>[];

      for (final doc in snapshot.docs) {
        final garage = await _getGarage(doc);

        if (isClosed) return;

        print('NEW GARAGE ID: ${garage.id}');
        print('NEW GARAGE: ${garage.name}');
        print('LEVELS: ${garage.levels.length}');

        newGarages.add(garage);
      }

      if (isClosed) return;

      allGarages.addAll(newGarages);

      await homeHive.saveGarages(allGarages);

      if (isClosed) return;

      emit(HomeSuccess(garages: allGarages));
    } catch (e) {
      print('=== LOAD MORE ERROR: $e ===');
    } finally {
      isLoadingMore = false;
    }
  }

  void searchGarages(String query) {
    if (isClosed) return;

    if (query.trim().isEmpty) {
      emit(HomeSuccess(garages: allGarages));
      return;
    }

    final filteredGarages = allGarages.where((garage) {
      return garage.name.toLowerCase().contains(
            query.toLowerCase(),
          ) ||
          garage.location.toLowerCase().contains(
            query.toLowerCase(),
          );
    }).toList();

    if (isClosed) return;

    emit(HomeSuccess(garages: filteredGarages));
  }

  Future<void> clearGarages() async {
    await homeHive.clearGarages();

    if (isClosed) return;

    allGarages.clear();

    lastDocument = null;
    hasMore = true;

    emit(HomeSuccess(garages: []));
  }
}
