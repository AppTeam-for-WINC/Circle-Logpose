import '../../domain/entity/user_profile.dart';

import '../model/user_profile_model.dart';

class UserProfileMapper {
  const UserProfileMapper();

  static UserProfile toEntity(UserProfileModel model) {
    return UserProfile(
      accountId: model.accountId,
      name: model.name,
      image: model.image,
      description: model.description,
      updatedAt: model.updatedAt,
      createdAt: model.createdAt,
    );
  }

  static UserProfileModel toModel(UserProfile entity) {
    return UserProfileModel(
      accountId: entity.accountId,
      name: entity.name,
      image: entity.image,
      description: entity.description,
      updatedAt: entity.updatedAt,
      createdAt: entity.createdAt,
    );
  }
}
