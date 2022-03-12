import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_bloc/blocs/blocs.dart';
import 'package:mapas_bloc/themes/estilo_mapa.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  StreamSubscription<LocationState>? locationStateSubscription;

  MapaBloc({ required this.locationBloc }) : super( const MapaState( ) ) {
    
    on<OnMapInitializedEvent>( _onInitMap );
    on<OnStarFollowingUserEvent>( _onStartFollowingUser );
    on<OnStopFollowingUserEvent>((event, emit) => emit( state.copyWith( isFollowUSer: false) ));
    on<UpdateUserPolylineEvent>( _onPolyLineNewPoint );
    on<OnToggleUserRoute>((event, emit) => emit( state.copyWith( showMyRoute: !state.showMyRoute)) );

    locationStateSubscription = locationBloc.stream.listen(( locationState ) {

      if( locationState.lastKnowLocation != null ){
        add( UpdateUserPolylineEvent( locationState.myLocationHistory ) );
      }
      
      if( !state.isFollowUSer ) return;
      if( locationState.lastKnowLocation == null ) return;

      moveCamera( locationState.lastKnowLocation! );

    });
    
  }

  void _onInitMap( OnMapInitializedEvent event, Emitter<MapaState> emit ) {

    _mapController = event.controller;
    _mapController!.setMapStyle( jsonEncode( uberMapTheme ));

    // _mapController!.setMapStyle( '[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]' );

    emit( state.copyWith( isMapInitialized: true ) );

  }

  void moveCamera( LatLng newLocation ){

    final camareUpdate = CameraUpdate.newLatLng( newLocation );
    _mapController?.animateCamera( camareUpdate );

  }

  void _onStartFollowingUser( OnStarFollowingUserEvent event, Emitter<MapaState> emit ){

    emit( state.copyWith( isFollowUSer: true ) );

    if( locationBloc.state.lastKnowLocation == null ) return;
    moveCamera( locationBloc.state.lastKnowLocation! );

  }

  void _onPolyLineNewPoint( UpdateUserPolylineEvent event, Emitter<MapaState> emit ){

    final myRoute = Polyline(
      polylineId: const PolylineId('MyRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations
    );

    final currentPolylines = Map<String, Polyline>.from( state.polylines );
    currentPolylines['myRoute'] = myRoute;

    emit( state.copyWith( polylines: currentPolylines ) );

  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }

}
