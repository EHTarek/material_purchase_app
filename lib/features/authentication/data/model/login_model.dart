
import 'package:material_purchase_app/features/authentication/domain/entity/login_entity.dart';

extension LoginRequestModel on LoginRequestEntity {
  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}

class LoginResponseModel extends LoginResponseEntity {
  LoginResponseModel({
    super.statusCode,
    super.statusMessage,
    super.accessToken,
    super.tokenType,
    super.expiresIn,
    super.userData,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    statusCode: json["status_code"],
    statusMessage: json["status_message"],
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    userData: json["user_data"] == null ? null : UserDataModel.fromJson(json["user_data"]),
  );

  @override
  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status_message": statusMessage,
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "user_data": userData?.toJson(),
  };
}

class UserDataModel extends UserDataEntity {
  UserDataModel({
    super.id,
    super.email,
    super.firstName,
    super.lastName,
    super.roleId,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    roleId: json["role_id"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "role_id": roleId,
  };
}
