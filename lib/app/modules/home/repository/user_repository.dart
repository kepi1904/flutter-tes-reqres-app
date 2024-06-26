import '../models/user_model.dart';

abstract class UserRepository {
  Future<List<User>?> getData({String id});
}
