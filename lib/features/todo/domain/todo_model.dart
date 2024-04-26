import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel with _$TodoModel {
  const factory TodoModel({
    required String id,
    required String name,
    required String desc,
    required DateTime date,
    required bool isCompleted,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  factory TodoModel.empty() => TodoModel(
        id: '',
        name: '',
        desc: '',
        date: DateTime.now().toLocal(),
        isCompleted: false,
      );

  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json) =>
      _$TodoModelFromJson(json.data()!);
}
