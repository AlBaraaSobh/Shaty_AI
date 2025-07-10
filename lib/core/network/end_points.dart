class EndPoints {
  static String baseUrl = "http://10.0.2.2:8000/api/";

  // static String baseUrl = 'http://192.168.1.69:8000/api/';// ip الجهاز 192.168.1.69
  static String register = 'register';
  static String login = 'login';
  static String tips = 'doctor/advice/store';
  static String getTips = 'doctor/get-today-advice';

  static String deleteTips(String tipId) => 'doctor/advice/$tipId/destroy';

  static String updateTip(String id) => 'doctor/advice/$id/update';
  static String createArticle = 'doctor/article/store';
  static String getArticle = 'doctor/articles';
  static String getAllArticle = 'doctors-articles';

  static String deleteArticle(String articleId) =>
      'doctor/article/delete/$articleId';

  static String updateArticle(String id) => 'doctor/article/$id/update';

  static String likeArticle(String id) => 'article/$id/like';

  static String saveArticle(String id) => 'article/$id/save';

  static String getSaveArticle(String id) => 'articles/saved';

  static String commentArticle(String id) => 'article/$id/comment/store';

  static String deleteCommentArticle(String id) => 'comment/$id/destroy';

  static String getCommentArticle(String id) => 'article/$id/comments';
  static String getDoctorProfile = 'doctor/my';
  static String updateDoctorBio = 'doctor/update-bio';
  static String getDoctorFollowers = 'doctor/followers';
  static String getDoctorInfo = 'doctor/info';
  static String updateDoctorProfile = 'doctor/update-profile';
  static String articleSaved = 'articles/saved';
  static String updateDoctorImage = 'doctor/update-img';
  static String doctorNotifications = 'doctor/notifications';
  static String changePassword = 'change-password';
  static String editDoctorProfile = 'doctor/update-profile';

  //patient
  static String getAllTips = 'user/get-today-advice';
  static String getAllFollowingDoctors = 'user/doctors';

  static String getDoctorsBySpecialty(String specialtyId) => "speciaty/$specialtyId/doctors";

  static String followDoctor(int doctorId) => "user/follow-doctor/$doctorId";
  static String patientNotifications = 'user/notifications';
  static String checkCode = 'check-code';
  static String resetPassword = 'reset-password';
  static String forgetPassword = 'forget-password';
  static String patientUpdateProfile = 'user/update-profile';

}
