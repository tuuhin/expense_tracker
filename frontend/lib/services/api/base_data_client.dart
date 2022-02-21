import 'package:dio/dio.dart';
import 'package:expense_tracker/services/api/base_client.dart';

class BaseDataClient extends Client {
  Future<Map?> getEntries() async {
    try {
      print('requesting');
      Response _response = await Client.dio.get('/entries');
      Map _data = _response.data as Map;
      return _data;
    } on DioError catch (error) {
      print(error.response);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map?> getEntriesByUrl(String url) async {
    try {
      print('requesting $url');
      Response _response = await Client.dio.get(url);
      Map _data = _response.data as Map;
      return _data;
    } on DioError catch (error) {
      print(error.response);
    } catch (e) {
      print(e.toString());
    }
  }
}
