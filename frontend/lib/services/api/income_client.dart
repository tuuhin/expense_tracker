import 'package:dio/dio.dart';
import 'package:expense_tracker/services/api/base_client.dart';

class IncomeClient extends Client {
  Future<bool?> addIncomeSource(String title,
      {String? desc, bool? isSecure}) async {
    try {
      Response _resp = await Client.dio.post('/sources',
          data: {'title': title, 'desc': desc, 'is_secure': isSecure});
      print(_resp.data);
      return true;
    } on DioError catch (e) {
      print(e.response);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool?> addNewIncome(
      {required String title,
      required num amount,
      String? desc,
      List<int>? sources}) async {
    try {
      Response _response = await Client.dio.post('/income', data: {
        'title': title,
        'desc': desc,
        'amount': amount,
        'source': sources
      });
      print(_response.requestOptions.baseUrl + _response.requestOptions.path);
      return true;
    } on DioError catch (e) {
      print(e.response);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List?> getIncomeSources() async {
    try {
      Response _resp = await Client.dio.get('/sources');
      return _resp.data;
    } on DioError catch (e) {
      print(e.response);
    } catch (e) {
      print(e.toString());
    }
  }
}
