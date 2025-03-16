interface class LoginEntity {}

class LoginRequestEntity extends LoginEntity {
  final String email;
  final String password;

  LoginRequestEntity({
    required this.email,
    required this.password,
  });
}

class LoginResponseEntity extends LoginEntity {
  String? statusCode;
  String? statusMessage;
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  UserDataEntity? userData;

  LoginResponseEntity({
    this.statusCode,
    this.statusMessage,
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.userData,
  });

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status_message": statusMessage,
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "user_data": userData?.toJson(),
  };
}

class UserDataEntity {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  int? roleId;

  UserDataEntity({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.roleId,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "role_id": roleId,
  };
}
