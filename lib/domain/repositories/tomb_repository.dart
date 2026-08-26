import '../models/tomb.dart';

abstract class TombRepository {
  Future<List<Tomb>> getAvailableTombs({String? city, String? status, String? sortBy});
  Future<Tomb> getTombDetail(String id);
  Future<List<String>> getCemeteryAreas(String cemeteryId);
}
