

import 'package:dio/dio.dart';


class TrafficInterceptor extends Interceptor {

  final accessToken = 'pk.eyJ1IjoiZGV2cm9kcmlnb2xvcGV6IiwiYSI6ImNrYzVuMXA0NjA2ejEycnFlZTdlNW15M2gifQ.t4EZfIvmGSTOxRRdSdm2Mg';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken,
    });

    super.onRequest(options, handler);
  }

}