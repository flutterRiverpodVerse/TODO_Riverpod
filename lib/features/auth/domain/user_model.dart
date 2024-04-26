import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    required String email,
    required String profileImage,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.empty() => const UserModel(
        id: '',
        name: '',
        email: '',
        profileImage: '',
      );

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json) =>
      _$UserModelFromJson(json.data()!);
}
