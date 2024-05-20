import '../../domain/entity/group_profile.dart';
import '../model/group_profile_model.dart';

class GroupProfileMapper {
  const GroupProfileMapper();

  static GroupProfile toEntity(GroupProfileModel model) {
    return GroupProfile(
      name: model.name,
      description: model.description,
      image: model.image,
      updatedAt: model.updatedAt,
      createdAt: model.createdAt,
    );
  }

  static GroupProfileModel toModel(GroupProfile entity) {
    return GroupProfileModel(
      name: entity.name,
      description: entity.description,
      image: entity.image,
      updatedAt: entity.updatedAt,
      createdAt: entity.createdAt,
    );
  }
}
