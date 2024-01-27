import 'package:askimam/common/domain/model/model.dart';

class AddChatToFavorites with Model {
  final int id;

  const AddChatToFavorites(this.id);

  @override
  Map<String, dynamic> toJson() => {'id': id};
}
