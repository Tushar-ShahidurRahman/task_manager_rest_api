class Urls {

static String baseUrl = 'https://task.teamrabbil.com/api/v1';
static String loginUrl = '$baseUrl/login';
static String registrationUrl = '$baseUrl/registration';
static String createNewTaskUrl = '$baseUrl/createTask';
static String getNewTaskUrl = '$baseUrl/listTaskByStatus/New';
static String getCompletedTaskUrl = '$baseUrl/listTaskByStatus/Completed';
static String getCancelledTaskUrl = '$baseUrl/listTaskByStatus/Cancelled';
static String getProgressTaskUrl = '$baseUrl/listTaskByStatus/Progress';
static String updateProfileUrl = '$baseUrl/profileUpdate';
static String getTaskStatusCountUrl = '$baseUrl/taskStatusCount';
static String recoverResetPasswordUrl = '$baseUrl/RecoverResetPass';
//In main app String in not nullable. I have to check that out.
static String updateTaskStatusUrl({required String taskId, required String status}) => '$baseUrl/updateTaskStatus/$taskId/$status';
static String recoveryByEmailVerificationUrl({required String email}) => '$baseUrl/RecoverVerifyEmail/$email';
static String getDeleteTaskUrl({required String id}) => '$baseUrl/deleteTask/$id';
static String recoveryVerifyOTPUrl({required String email, required String otp}) => '$baseUrl/RecoverVerifyOTP/$email/$otp';

}