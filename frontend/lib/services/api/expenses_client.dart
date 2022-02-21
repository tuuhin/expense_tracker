import 'package:dio/dio.dart';
import 'package:expense_tracker/services/api/base_client.dart';

class ExpensesClient extends Client {
  Future<bool?> addExpenseCategory(String title, {String? desc}) async {
    try {
      Response _resp = await Client.dio
          .post('/categories', data: {'title': title, 'desc': desc});
      print(_resp.data);
      return true;
    } on DioError catch (e) {
      print(e.response);
    } catch (e) {
      print(e.toString());
    }
  }
}
