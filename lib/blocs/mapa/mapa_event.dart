part of 'mapa_bloc.dart';

abstract class MapaEvent extends Equatable {
  const MapaEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapaEvent{
  final GoogleMapController controller;

  const OnMapInitializedEvent(this.controller);

}


class OnStopFollowingUserEvent extends MapaEvent{}

class OnStarFollowingUserEvent extends MapaEvent{} 

class UpdateUserPolylineEvent extends MapaEvent{

  final List<LatLng> userLocations;
  UpdateUserPolylineEvent(this.userLocations);

}

class OnToggleUserRoute extends MapaEvent{}