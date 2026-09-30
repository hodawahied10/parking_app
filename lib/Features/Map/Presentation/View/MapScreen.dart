import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:parkingapp/Core/Shared_Widgets/BottomNav.dart';
import 'package:parkingapp/Core/Shared_Widgets/BottomNavNavigation.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

import 'package:parkingapp/Features/Map/Presentation/Manager/MapViewCubit.dart';
import 'package:parkingapp/Features/Map/Presentation/Manager/MapViewState.dart';

class MapScreen extends StatelessWidget {
  static const String routeName = "/MapScreen";

  const MapScreen({super.key});

  static const LatLng initialLocation = LatLng(
    30.0444,
    31.2357,
  );

  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController();

    return Scaffold(
      backgroundColor: ColorManager.primaryBG,

      body: BlocBuilder<MapCubit, MapLocationState>(
        builder: (context, state) {
          if (state is MapLocationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          LatLng mapCenter = initialLocation;

          if (state is MapLocationSuccess) {
            mapCenter = LatLng(
              state.position.latitude,
              state.position.longitude,
            );
          }

          return FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: mapCenter,
              initialZoom: state is MapLocationSuccess ? 15 : 12,
              minZoom: 5,
              maxZoom: 18,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.parkingapp',
              ),

              if (state is MapLocationSuccess)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(
                        state.position.latitude,
                        state.position.longitude,
                      ),
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.location_on,
                        color: ColorManager.buttonColor,
                        size: 45.sp,
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),

      bottomNavigationBar: Bottomnav(
        currentIndex: 1,
        ontap: (index) {
          BottomNavNavigation.navigate(
            context,
            index,
          );
        },
      ),
    );
  }
}