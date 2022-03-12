import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_bloc/blocs/blocs.dart';


class ManualMarker extends StatelessWidget {
  const ManualMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state){

        return state.displayManualMarker 
          ? const _ManualMarkerBody()
          : const SizedBox();

      }
    );
  }
}


class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [

          const Positioned(
            top: 70,
            left: 20,
            child: _btnBack(),
          ),

          Center(
            child: Transform.translate(
              offset: const Offset(0, -22),
              child: BounceInDown(
                from: 100,
                child: const Icon( Icons.location_on_rounded, size: 60, color: Colors.white )
              ),
            ),
          ),

          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              duration: const Duration( milliseconds: 300 ),
              child: MaterialButton(
                minWidth: size.width - 120,
                child: const Text( 'Confirmar destino', style: TextStyle( color: Colors.black, fontWeight: FontWeight.w700 ), ),
                color: Colors.white,
                elevation: 0,
                height: 50,
                shape: const StadiumBorder(),
                onPressed: (){}
              ),
            )
          )

        ],
      ),
    );
  }
}

class _btnBack extends StatelessWidget {
  const _btnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration( milliseconds: 300 ),
      child: CircleAvatar(
        maxRadius: 20,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon( Icons.arrow_back_ios_new, color: Colors.black ),
          onPressed: (){
    
          },
        ),
      ),
    );
  }
}