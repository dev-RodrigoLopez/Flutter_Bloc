part of 'mapa_bloc.dart';

 class MapaState extends Equatable {

  final bool isMapInitialized;
  final bool isFollowUSer;
  final bool showMyRoute;

  //Polilynes
  final Map<String, Polyline> polylines;

  const MapaState({
    this.isMapInitialized = false, 
    this.isFollowUSer = false,
    this.showMyRoute = true,
    Map<String, Polyline>? polylines,
  }): polylines = polylines ?? const {};

  MapaState copyWith({
    bool? isMapInitialized,
    bool? isFollowUSer,
    bool? showMyRoute,
    Map<String, Polyline>? polylines,
  }) => MapaState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowUSer: isFollowUSer ?? this.isFollowUSer,
    showMyRoute: showMyRoute ?? this.showMyRoute,
    polylines: polylines ?? this.polylines,
  );
  
  @override
  List<Object> get props => [ isMapInitialized, isFollowUSer, showMyRoute, polylines];

}


