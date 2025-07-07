import 'package:shaty/core/network/end_points.dart';

import '../../../../core/network/api_consumer.dart';
import '../../../doctor/data/models/tips_model.dart';

class TipsPatientRepository {
  final ApiConsumer api;

  TipsPatientRepository(this.api);

  Future<List<TipsModel>> getTodayAdvice({int page = 1}) async {
    final response = await api.get(
     EndPoints.getAllTips,
      queryParameters: {'page': page},
    );
    final List data = response['data'];
    return data.map((e) => TipsModel.fromJson(e)).toList();
  }
}