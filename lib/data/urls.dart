class Urls {

static String baseUrl = 'https://task.teamrabbil.com/api/v1';
static String loginUrl = '$baseUrl/login';
static String registrationUrl = '$baseUrl/registration';
static String createNewTaskUrl = '$baseUrl/createTask';
static String getNewTaskUrl = '$baseUrl/listTaskByStatus/New';
static String getCompletedTaskUrl = '$baseUrl/listTaskByStatus/Completed';
static String updateTaskStatusUrl({String? taskId, String? status}) => '$baseUrl/updateTaskStatus/$taskId/$status';
}