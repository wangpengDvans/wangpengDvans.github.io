import '../models/memorial_profile.dart';

abstract class MemorialRepository {
  Future<MemorialProfile> getMemorialProfile(String id);
  Future<MemorialProfile> interact(String id, String type);
}
