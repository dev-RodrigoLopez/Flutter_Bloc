import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? gpsServiceSubscription;

  GpsBloc() : super( const GpsState( isGPSEnabled: false, isGPSPermissionGranted: false) ) {

    on<GpsAndPermissionEvent>((event, emit) => emit( state.copyWith(
      isGPSEnabled: event.isGpsEnabled,
      isGPSPermissionGranted: event.isGpsPermissionGranted
    ) ));

    _init();

  }

  Future<void> _init() async{
    // final isEnabled = await _checkGPSStatus();
    // final isGranted = await _isPermissionGranted();
    // print( 'isEnabled: $isEnabled isGranted $isGranted' );

    //Hacer los Futures de manera simultanea
    final gpsIniStatus = await Future.wait([
      _checkGPSStatus(),
      _isPermissionGranted()
    ]);

    add( GpsAndPermissionEvent(
      isGpsEnabled: gpsIniStatus[0], 
      isGpsPermissionGranted: gpsIniStatus[1]
    ) );

  }

  Future<bool> _isPermissionGranted() async{

    final isGranted = await Permission.location.isGranted;
    return isGranted;
  
  }

  Future<bool> _checkGPSStatus() async{

    final isEnable = await Geolocator.isLocationServiceEnabled();

    gpsServiceSubscription = Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = ( event.index == 1 ) ? true: false;
      add( GpsAndPermissionEvent(
        isGpsEnabled: isEnabled, 
        isGpsPermissionGranted: state.isGPSPermissionGranted
      ) );
    });

    return isEnable;

  }

  Future<void> askGPSAccess() async{

    final status = await Permission.location.request();
    switch( status ){
      
      case PermissionStatus.granted:
        add( GpsAndPermissionEvent(isGpsEnabled: state.isGPSEnabled, isGpsPermissionGranted: true) );
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add( GpsAndPermissionEvent(isGpsEnabled: state.isGPSEnabled, isGpsPermissionGranted: true) );
        openAppSettings();
    }

  }


  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }

}
