import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mapas_bloc/blocs/blocs.dart';

import 'package:mapas_bloc/views/views.dart';
import 'package:mapas_bloc/widgets/btn_toggle_user_route.dart';
import 'package:mapas_bloc/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({ Key? key }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();

  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: ( context, locationState ){

          if( locationState.lastKnowLocation == null ) return const Center(child: Text('Espere por favor...'));
         
          return BlocBuilder<MapaBloc, MapaState>(
            builder: (context, mapasState) {

              Map<String, Polyline> polylines = Map.from( mapasState.polylines );
              if( !mapasState.showMyRoute ){
                polylines.removeWhere((key, value) => key == 'myRoute');
              }

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView( 
                      initialLocation:  locationState.lastKnowLocation! ,
                      polylines: polylines.values.toSet(),
                    ),

                    const SearchBar()

                  ],
                ),
              );
            },
          );

        }
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnToggleUserRoute(),
          BtnFollowUser(),
          BtnCurrentLocation(),

        ],
      ),

    );
  }
}