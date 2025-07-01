import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatbotRepository {
  final Dio dio;

  ChatbotRepository(this.dio);

  final String _apiKey = dotenv.env['OPENROUTER_API_KEY'] ?? '';
  final String _baseUrl = 'https://openrouter.ai/api/v1/chat/completions';

  Future<String> getBotReply(String message) async {
    try {
      final response = await dio.post(
        _baseUrl,
        data: {
          "model": "mistralai/mistral-7b-instruct",
          "messages": [
            {
              "role": "system",
              "content": "أنت مساعد طبي افتراضي مختص في تقديم استشارات صحية أولية فقط. "
                  "أجب على المستخدم بلغة العربية فقط "
                  " بلغة واضحة ومبسطة. لا تخرج عن المجال الطبي،"
                  " وقم بتشخيص الحالات بدقة وقم بوصف أفضل أدوية والبديل لها. إذا كان السؤال خارج المجال الطبي،"
                  " اعتذر بلطف ووجه المستخدم للرجوع للمواضيع الصحية."
            },
            {
              "role": "user",
              "content": message,
            }
          ]
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json',
            'HTTP-Referer': 'https://github.com/AlBaraaSobh/Shaty_AI',
            'X-Title': 'Shaty_AI Health ChatBot',
          },
        ),
      );

      final content = response.data['choices'][0]['message']['content'];
      return content ?? 'لم أتمكن من تقديم إجابة حالياً.';
    } catch (e) {
      print(' Error in getBotReply: $e');
      return 'حدث خطأ أثناء التواصل مع الذكاء الاصطناعي.';
    }
  }
}
