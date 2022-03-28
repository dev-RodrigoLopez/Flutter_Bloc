import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_bloc/models/model.dart';
import 'package:mapas_bloc/services/services.dart';

class TrafficService{

  final Dio _dioTraffic;
  final Dio _dioPlaces;

  final String _baseTraficURL = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _basePlacesURL = 'https://api.mapbox.com/geocoding/v5/mapbox.places';

  TrafficService() 
      : _dioTraffic = Dio()..interceptors.add( TrafficInterceptor() ),
        _dioPlaces = Dio()..interceptors.add( PlacesInterceptor() ); //Configurar interceptores

  Future<TrafficResponse> getCoorsStartToEnd( LatLng start, LatLng end ) async {

    final coorsString = ' ${ start.longitude}, ${ start.latitude }; ${ end.longitude }, ${ end.latitude } ';
    final url = '$_baseTraficURL/driving/$coorsString';

    final resp = await _dioTraffic.get(url);

    final data = TrafficResponse.fromMap( resp.data);

    return data;

  }
  Future<List<Feature>> getResultByQuery( LatLng proximity, String query ) async{

    if( query.isEmpty ) return [];

    final url = '$_basePlacesURL/$query.json';

    final resp = await _dioPlaces.get( url, queryParameters : {
      'proximity' : '${ proximity.longitude } , ${ proximity.latitude}'
    } );

    final placesResponse = PlacesResponse.fromJson( resp.data );

    return placesResponse.features;

  }

}