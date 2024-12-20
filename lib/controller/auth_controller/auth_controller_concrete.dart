import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hire4consult/controller/auth_controller/auth_controller.dart';

class AuthControllerConcrete with ChangeNotifier implements AuthController {
  bool _isLoading = false;

  @override
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    Future.microtask(() {
      notifyListeners(); // Ensure listeners are notified immediately
    });
  }

  @override
  Future<String?> signUpController(
      {required String email, required password}) async {
    _setLoading(true);
    await Future.delayed(const Duration(seconds: 3));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    } finally {
      _setLoading(false);
    }
  }

  @override
  Future<String?> loginController(
      {required String email, required password}) async {
    _setLoading(true);
    await Future.delayed(const Duration(seconds: 3));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password entered for that user.";
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    } finally {
      _setLoading(false);
    }
  }
}
