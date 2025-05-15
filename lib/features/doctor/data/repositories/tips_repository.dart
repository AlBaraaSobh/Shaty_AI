import 'package:dio/dio.dart';
import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/utils/helpers/storage_helper.dart';
import '../models/tips_model.dart';

class TipsRepository {
  final ApiConsumer api;

  TipsRepository(this.api);

  Future<TipsModel> addTip(String tip) async {

    final token = await StorageHelper.getToken();
    if (token == null) throw Exception("Token is missing");
    final response = await api.post(
      EndPoints.baseUrl + EndPoints.tips,
      data: {"advice": tip},
      options: Options(headers: {
        "Authorization": "Bearer ${token}",
      }),
    );
    final tipData = response['data']; // <-- هذا هو الـ Tip نفسه
    return TipsModel.fromJson(tipData);
    // return TipsModel.fromJson(response['data']);
  }

  Future<List<TipsModel>> getTips() async {
    final token = await StorageHelper.getToken();
    if (token == null) throw Exception("Token is missing");
    final response = await api.get(
      EndPoints.baseUrl + EndPoints.getTips,
      options: Options(headers: {
        "Authorization": "Bearer ${token}",
      }),
    );
    // final List<dynamic> data = [
    //   {
    //     "id": 8,
    //     "advice": "test2"
    //   },
    //   {
    //     "id": 7,
    //     "advice": "test6"
    //   }
    // ];
    final List<dynamic> data = response['data'];
    return data.map((e)=> TipsModel.fromJson(e)).toList();
  }
}
