import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_bloc/blocs/blocs.dart';
import 'package:mapas_bloc/delegate/delegate.dart';
import 'package:mapas_bloc/models/model.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: ( context, state ){
        return state.displayManualMarker
          ? const SizedBox()
          : const _SearchBarBody();
      }
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({Key? key}) : super(key: key);

  void onSearchResults( BuildContext context, SearchResult result ){

    final searchBloc = BlocProvider.of<SearchBloc>(context);

    if( result.manual ){
      searchBloc.add( OnActivateManualMarkerEvent() );
      return;
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only( top:10 ),
        padding: const EdgeInsets.symmetric( horizontal: 30 ),
        // color: Colors.red,
        width: double.infinity,
        height: 50,
        child: GestureDetector(
          onTap: () async{
            final result = await showSearch(context: context, delegate: SearchDestinationDelegate());

            if( result == null ) return;
            onSearchResults(context, result);



          },
          child: Container(
            padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 13),
            child: const Text( 'Donde quieres ir', style: TextStyle( color: Colors.black87 ), ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset( 0,5 )
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}