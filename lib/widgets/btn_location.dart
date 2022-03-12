import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mapas_bloc/blocs/blocs.dart';
import 'package:mapas_bloc/ui/ui.dart';


class BtnCurrentLocation extends StatelessWidget {

  const BtnCurrentLocation({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final locationBloc = BlocProvider.of<LocationBloc>( context );
    final mapaBloc = BlocProvider.of<MapaBloc>( context );

    return Container(
      margin: const EdgeInsets.only( bottom: 10 ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon( Icons.my_location_outlined, color: Colors.black, ),
          onPressed: (){


            final userLocation = locationBloc.state.lastKnowLocation;
            if( userLocation == null ) {
              
              final  snack = CustomSnackBar(message: 'No hay ubicacion');
              ScaffoldMessenger.of(context).showSnackBar(snack);
              return ;
              
            };

            mapaBloc.moveCamera( userLocation );

          },
        ),
      ),
    );
  }
}