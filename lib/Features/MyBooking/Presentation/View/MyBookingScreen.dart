import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/Core/Shared_Widgets/BottomNav.dart';
import 'package:parkingapp/Core/Shared_Widgets/BottomNavNavigation.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Features/Booking/Presentation/Manager/BookingCubit.dart';
import 'package:parkingapp/Features/Booking/Presentation/Manager/BookingState.dart';

import 'package:parkingapp/Features/MyBooking/Presentation/widget/EmptyBookingState.dart';
import 'package:parkingapp/Features/MyBooking/Presentation/widget/HistoryBookings.dart';
import 'package:parkingapp/Features/MyBooking/Presentation/widget/UpcomingBookings.dart';

class MyBookingScreen extends StatelessWidget {
  static const String routeName = "/MyBookingScreen";

  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorManager.primaryBG,
        appBar: AppBar(
          backgroundColor: ColorManager.primaryBG,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "My Bookings",
            style: TextStyle(
              color: ColorManager.titleColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),

              // =========================
              // Upcoming / History
              // =========================
              Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: ColorManager.buttonColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: ColorManager.subtitleColor,
                  labelStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: const [
                    Tab(text: "Upcoming"),
                    Tab(text: "History"),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // =========================
              // Bookings
              // =========================
              Expanded(
                child: BlocConsumer<BookingCubit, BookingState>(
                  listener: (context, state) {
                    // =========================
                    // Cancel Success
                    // =========================

                    if (state is BookingCancelSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Booking cancelled successfully."),
                        ),
                      );

                      context.read<BookingCubit>().getBookings();
                    }

                    // =========================
                    // Cancel Error
                    // =========================

                    if (state is BookingCancelErrorState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }

                    // =========================
                    // Get / Load Error
                    // =========================

                    if (state is BookingErrorState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },

                  builder: (context, state) {
                    final cubit = context.read<BookingCubit>();

                    // =========================
                    // Loading
                    // =========================

                    if (state is BookingLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // =========================
                    // Error Loading Bookings
                    // =========================

                    if (state is BookingErrorState) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorManager.subtitleColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      );
                    }

                    // =========================
                    // Loaded / Cancel Error
                    // =========================

                    if (state is BookingLoadedState ||
                        state is BookingCancelErrorState) {
                      return TabBarView(
                        children: [
                          // =========================
                          // Upcoming
                          // =========================

                          cubit.upcomingBookings.isEmpty
                              ? const EmptyBookingState()
                              : UpcomingBookings(
                                  bookings: cubit.upcomingBookings,
                                  onCancel: (booking) {
                                    cubit.cancelBooking(booking);
                                  },
                                ),

                          // =========================
                          // History
                          // =========================
                          cubit.historyBookings.isEmpty
                              ? const EmptyBookingState()
                              : HistoryBookings(
                                  bookings: cubit.historyBookings,
                                ),
                        ],
                      );
                    }

                    return const EmptyBookingState();
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Bottomnav(
          currentIndex: 2,
          ontap: (index) {
            BottomNavNavigation.navigate(context, index);
          },
        ),
      ),
    );
  }
}
