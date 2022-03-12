import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_bloc/blocs/blocs.dart';
import 'package:mapas_bloc/blocs/gps/gps_bloc.dart';

import 'screens/screens.dart';

void main() {

  runApp( MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GpsBloc() ),
      BlocProvider(create: (context) => LocationBloc() ),
      BlocProvider(create: (context) => MapaBloc( locationBloc: BlocProvider.of<LocationBloc>(context) ) )
    ], 
    child: const MapsApp()
  ) );
}

class MapsApp extends StatelessWidget {

  const MapsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps APP',
      home: LoadingScreen(),
    );
  }
}