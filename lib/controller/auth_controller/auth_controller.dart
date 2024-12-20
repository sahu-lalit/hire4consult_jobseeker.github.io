abstract class AuthController {
  Future<String?> loginController(
      {required String email, required dynamic password});
  Future<String?> signUpController({required String email, required password});
  bool get isLoading;
}
