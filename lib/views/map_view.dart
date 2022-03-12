import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_bloc/blocs/blocs.dart';

class MapView extends StatelessWidget {

  final LatLng initialLocation;
  final Set<Polyline> polylines;

  const MapView({ 
    Key? key, 
    required this.initialLocation, 
    required this.polylines 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final CameraPosition initialCamaraPosition = CameraPosition(
      // bearing: 192.8334901395799,
      target: initialLocation,
      // tilt: 59.440717697143555,
      zoom: 15
    );

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    final size = MediaQuery.of(context).size;

     return SizedBox(
       width: size.width,
       height: size.height,
       child: Listener(
         onPointerMove: ( pointerMoveEvent ) => mapaBloc.add( OnStopFollowingUserEvent() ),
         child: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: initialCamaraPosition, 
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            polylines: polylines,
            onMapCreated: ( controller ) => mapaBloc.add( OnMapInitializedEvent(controller) ),
          ),
       ),
     );
  }
}