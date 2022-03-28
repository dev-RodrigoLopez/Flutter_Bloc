

import 'package:dio/dio.dart';


class PlacesInterceptor extends Interceptor{

  final accessToken = 'pk.eyJ1IjoiZGV2cm9kcmlnb2xvcGV6IiwiYSI6ImNrYzVuMXA0NjA2ejEycnFlZTdlNW15M2gifQ.t4EZfIvmGSTOxRRdSdm2Mg';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    

    options.queryParameters.addAll({
      'access_token': accessToken,
      'language': 'es',
      'limit': 7
    });

    super.onRequest(options, handler);
  }

}