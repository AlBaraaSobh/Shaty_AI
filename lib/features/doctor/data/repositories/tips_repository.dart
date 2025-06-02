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
      EndPoints.tips,
      data: {"advice": tip},
    );
    final tipData = response['data'];
    return TipsModel.fromJson(tipData);
  }

  Future<void> deleteTips(int id) async {
    final token = await StorageHelper.getToken();
    if (token == null) throw Exception("Token is missing");
    final response = api.delete(
      EndPoints.deleteTips('$id'),

    );
  }

  Future<TipsModel> updateTip({
    required String id,
    required String advice,
  }) async {
    final token = await StorageHelper.getToken();
    if (token == null) throw Exception("Token is missing");
    final response = await api.post(
      EndPoints.updateTip(id),
      data: {"advice": advice},

    );
    return TipsModel.fromJson(response['data']);
  }

  Future<List<TipsModel>> getTips() async {
    final token = await StorageHelper.getToken();
    if (token == null) throw Exception("Token is missing");
    final response = await api.get(
      EndPoints.getTips,

    );

    final List<dynamic> data = response['data'];
    return data.map((e) => TipsModel.fromJson(e)).toList();
  }
}
