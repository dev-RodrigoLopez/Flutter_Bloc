import 'package:flutter/material.dart';
import 'package:mapas_bloc/blocs/blocs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {

            print( state );

            return !state.isGPSEnabled
              ? const _EnableGpsMessage()
              : const _AccessBoton();
          },
        )
      ),
    );
  }
}

class _AccessBoton extends StatelessWidget {
  const _AccessBoton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Es necesario el acceso a GPS'),
        MaterialButton(
          child: const Text('Solicitar Acesso', style: TextStyle( color: Colors.white )),
          color: Colors.black,
          shape: const StadiumBorder(),
          elevation: 0,
          onPressed: (){

            final gpsBloc = BlocProvider.of<GpsBloc>(context);
            gpsBloc.askGPSAccess();

          },
        )
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text( 
      'Debe de habilitar el GPS' ,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w300
      ),
    );
  }
}