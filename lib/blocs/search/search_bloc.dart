import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_bloc/models/model.dart';
import 'package:mapas_bloc/services/services.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  TrafficService trafficService;

  SearchBloc({
    required this.trafficService
  }) : super(const SearchState()) {

    on<OnActivateManualMarkerEvent>((event, emit) => emit( state.copyWith( displayManualMarker: true ) ));
    on<OnDeactivateActivateManualMarkerEvent>((event, emit) => emit( state.copyWith( displayManualMarker: false ) ));
    on<OnNewPlacesFoundEvent>((event, emit) => emit( state.copyWith( places: event.places ) ));
    on<AddHistoryEvent>((event, emit) => emit( state.copyWith( history: [ event.place, ...state.history ] ) ));

    
  }

  Future<RouteDestination> getCoorsStartToEnd( LatLng start,LatLng end ) async {

    final resp = await trafficService.getCoorsStartToEnd(start, end);

    final distance = resp.routes[0].distance;
    final duration = resp.routes[0].duration;
    final geometry = resp.routes[0].geometry;

    //Decodoficar
    final points = decodePolyline( geometry, accuracyExponent: 6 );
    final latLngList = points.map( ( coor) => LatLng( coor[0].toDouble(), coor[1].toDouble() )  ).toList();



    return RouteDestination(
      points: latLngList, 
      duration: duration, 
      distance: distance
    );

  }

  Future getPlacesByQuery( LatLng proximity, String query ) async{

    final newPlaces = await trafficService.getResultByQuery(proximity, query);

    add( OnNewPlacesFoundEvent(newPlaces) );

  }

}
