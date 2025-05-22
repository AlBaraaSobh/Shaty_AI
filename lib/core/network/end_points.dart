class EndPoints{
  static String baseUrl = "http://10.0.2.2:8000/api/";
  // static String baseUrl = 'http://192.168.1.69:8000/api/';// ip الجهاز 192.168.1.69
  static  String register = 'register';
  static  String login = 'login';
  static  String tips = 'doctor/advice/store';
  static  String getTips = 'doctor/get-today-advice';
  static String deleteTips(String tipId) => 'doctor/advice/$tipId/destroy';
  static String updateTip(String id) => 'doctor/advice/$id/update';
  static  String createArticle = 'doctor/article/store';
  static  String getArticle = 'doctor/articles';
  static String deleteArticle(String articleId) => 'doctor/article/delete/$articleId';
  static String updateArticle(String id) => 'doctor/article/$id/update';




}