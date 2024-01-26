import 'package:askimam/common/domain/model/model.dart';

class UpdateChat with Model {
  final String subject;

  const UpdateChat(this.subject);

  @override
  Map<String, dynamic> toJson() => {
        'subject': subject,
      };
}
