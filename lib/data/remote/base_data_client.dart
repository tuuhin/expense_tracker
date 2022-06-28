import 'package:dio/dio.dart';
import 'package:expense_tracker/data/remote/base_client.dart';

class BaseDataClient extends Client {
  Future<Map?> getOverview() async {
    return null;
  }

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
    return null;
  }

  Future<Map?> getEntriesByUrl(String? url) async {
    try {
      if (url != null) {
        print('requesting $url');
        Uri _url = Uri.parse(url);
        print(_url.queryParameters);
        Response _response = await Client.dio.get(
          url,
          queryParameters: _url.queryParameters,
        );
        Map _data = _response.data as Map;
        return _data;
      }
    } on DioError catch (error) {
      print(error.response);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
