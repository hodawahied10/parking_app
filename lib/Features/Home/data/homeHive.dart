import 'package:hive/hive.dart';

import 'package:parkingapp/Features/Home/data/model/GarageModel.dart';

class HomeHive {
  static const String _boxName = "home";

  Future<Box<GarageModel>> _openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<GarageModel>(_boxName);
    }
    return await Hive.openBox<GarageModel>(_boxName);
  }

  Future<void> saveGarages(List<GarageModel> garages) async {
    final box = await _openBox();
    await box.clear();
    await box.addAll(garages);
  }

  Future<List<GarageModel>> getGarages() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> clearGarages() async {
    final box = await _openBox();
    await box.clear();
  }
}
