class UserModel {
  String id;
  String identifier;
  String identifierType;

  UserModel({
    required this.id,
    required this.identifier,
    required this.identifierType
});

  factory UserModel.fromJson(dynamic map) {
    return UserModel(id: map["user_id"], identifier: map["identifier"], identifierType: map["identifier_type"] );
  }

}