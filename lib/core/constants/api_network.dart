class ApiNetwork {
// BASE URL
  // static const String baseUrl = "https://hrm-api.threemad.com/api/";
  // static const String imageUrl = "https://hrm-api.threemad.com/";
  // static const String fileDownloadUrl = "https://hrm-api.threemad.com/";
  static const String baseUrl = "http://192.168.1.6:1987/api/";
  static const String imageUrl = "http://192.168.1.6:1987/";
  static const String fileDownloadUrl = "http://192.168.1.6:1987/";

  // LOGIN
  static const String login = "${baseUrl}login";
  static const String loginVerify = "${baseUrl}login/verify";
  static const String forgotPassword = "${baseUrl}login/forgot-password";
  static const String users = "${baseUrl}users";
  static const String deleteUsers = "${baseUrl}user/delete/";
  static const String updateUsers = "${baseUrl}user/update";
  static const String logout = "${baseUrl}logout";
  static const String updateProfile = "${baseUrl}update-profile";
  static const String settings = "${baseUrl}settings";
  static const String updateSettings = "${baseUrl}settings/update";
  // ROLES
  static const String roles = "${baseUrl}rolemobile";
  static const String roleCreate = "${baseUrl}role/create";
  static const String roleUpdate = "${baseUrl}role/update/";
  static const String permission = "${baseUrl}permissionsmobile";
  static const String roleDelete = "${baseUrl}role/delete/";
  static const String createUser = "${baseUrl}user/create";
  static const String userDelete = "${baseUrl}user/delete/";
  static const String roleDropdown = "${baseUrl}role-dropdown";

  // TASK
  static const String tasks = "${baseUrl}tasks";
  static const String createTask = "${baseUrl}task";
  static const String updateTask = "${baseUrl}task/";
  static const String taskDelete = "${baseUrl}task/";
  static const String taskAction = "${baseUrl}task-action/";
  static const String projectDropdown = "${baseUrl}project-dropdown";
  static const String boardDropdown = "${baseUrl}board-dropdown";

  //Board
  static const String getBoard = "${baseUrl}boards";
  static const String createBoard = "${baseUrl}board";
  static const String updateBoard = "${baseUrl}board/";
  static const String boardDelete = "${baseUrl}board/";

  // Admin/Manpower
  static const String manpowers = "${baseUrl}manpowers";
  static const String manpowerDelete = "${baseUrl}manpower/";
  static const String manpowerUpdate = "${baseUrl}manpower/";
  static const String manpowerCreate = "${baseUrl}manpower";
  static const String employeeListDropdown = "${baseUrl}manpower-dropdown";
  static const String createRole = "${baseUrl}role/create";

  //Department
  static const String departments = "${baseUrl}departments";
  static const String createDepartment = "${baseUrl}department";
  static const String departmentDelete = "${baseUrl}department/";
  static const String updateDepartment = "${baseUrl}department/";
  static const String departmentDropdown = "${baseUrl}department-dropdown";

  //Discipline
  static const String discipline = "${baseUrl}disciplines";
  static const String createDiscipline = "${baseUrl}discipline";
  static const String disciplineDelete = "${baseUrl}discipline/";
  static const String editDiscipline = "${baseUrl}discipline/";
//Attendance
  static const String attendance = "${baseUrl}attendances";
  static const String usersDropdown = "${baseUrl}users-dropdown";
  static const String createAttendance = "${baseUrl}attendance";
  static const String attendanceDelete = "${baseUrl}attendance/";
  static const String editAttendance = "${baseUrl}attendance/";
//Salary Management
  static const String salaryList = "${baseUrl}salaries";
  static const String createSalary = "${baseUrl}salary";
  static const String editSalary = "${baseUrl}salary/";
  static const String salaryDelete = "${baseUrl}salary/";

  //Interview
  static const String interviewList = "${baseUrl}interviews";
  static const String createInterview = "${baseUrl}interview";
  static const String updateInterview = "${baseUrl}interview/";
  static const String deleteInterview = "${baseUrl}interview/";

  // Leaves
  static const String leaves = "${baseUrl}leaves";
  static const String createLeave = "${baseUrl}leave";
  static const String updateLeave = "${baseUrl}leave/";
  static const String leaveDelete = "${baseUrl}leave/";

  // Birthday Aniversary
  static const String birthdayAniversary = "${baseUrl}birthday-anniversary";

  //Projects
  static const String projects = "${baseUrl}projects";
  static const String projectDelete = "${baseUrl}project/";
  static const String projectCreate = "${baseUrl}project/";
  static const String projectUpdate = "${baseUrl}project/";

  //Holidays
  static const String holidayList = "${baseUrl}holidays";
  static const String createHoliday = "${baseUrl}holiday";
  static const String updateHoliday = "${baseUrl}holiday/";
  static const String holidayDelete = "${baseUrl}holiday/";
}
