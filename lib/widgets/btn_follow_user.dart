import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mapas_bloc/blocs/blocs.dart';

class BtnFollowUser extends StatelessWidget {
  const BtnFollowUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: BlocBuilder<MapaBloc, MapaState>(

          builder: (context, state) {
            return IconButton(
              icon: Icon(
                state.isFollowUSer ? Icons.directions_run_rounded : Icons.hail_rounded,
                color: Colors.black,
              ),
              onPressed: () {

                mapaBloc.add( OnStarFollowingUserEvent() );

              },
            );
          },

        ),
      ),
    );
  }
}
