import '../../data/models/group_profile.dart';

abstract class IGroupRepository {
  Future<String> create(String name, String? image, String? description);

  Future<List<String>> fetchAllGroupId(String userId);

  Stream<GroupProfile?> watch(String docId);

  Future<GroupProfile> fetchGroup(String docId);

  Future<void> update({
    required String docId,
    required String? name,
    required String? description,
    required String? image,
  });

  Future<void> delete(String docId);
}
