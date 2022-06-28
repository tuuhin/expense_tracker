import 'package:dio/dio.dart';
import 'package:expense_tracker/data/remote/base_client.dart';

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
    return null;
  }

  Future<bool?> addExpense(String title,
      {required List<int> categories,
      required num amount,
      String? desc}) async {
    try {
      print('adding');
      Response _response = await Client.dio.post('/expenses', data: {
        'title': title,
        'desc': desc,
        'amount': amount,
        'categories': categories
      });
      print('done');
      print(_response.data);
      return true;
    } on DioError catch (e) {
      print(e.response);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List?> getCategories() async {
    try {
      Response _response = await Client.dio.get('/categories');
      return _response.data;
    } on DioError catch (e) {
      print(e.response);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
