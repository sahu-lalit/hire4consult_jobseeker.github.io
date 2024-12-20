import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hire4consult/controller/user_controller/user_controller.dart';
import 'package:hire4consult/model/user_model/user_model.dart';

class UserControllerConcrete implements UserController {
  final FirebaseFirestore firestore;

  UserControllerConcrete(this.firestore);

  @override
  Future<UserModel?> getUserDetails(String userId) async {
    final userDoc = await firestore.collection('users').doc(userId).get();
    if (userDoc.exists) {
      return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
    }
    return null;
  }
}