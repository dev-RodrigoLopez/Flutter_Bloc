import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mapas_bloc/blocs/blocs.dart';

class BtnToggleUserRoute extends StatelessWidget {
  const BtnToggleUserRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child:IconButton(
              icon: const Icon(
                Icons.more_horiz_rounded,
                color: Colors.black,
              ),
              onPressed: () {

                mapaBloc.add( OnToggleUserRoute() );

              },
            )
      ),
    );
  }
}
