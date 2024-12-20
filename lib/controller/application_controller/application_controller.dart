abstract class ApplicationController {
  Future<void> submitApplication(String jobId, String userId,
      Map<String, dynamic> jobDetails, Map<String, dynamic> userDetails);
}
