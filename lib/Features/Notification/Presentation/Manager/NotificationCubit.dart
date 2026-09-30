import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:parkingapp/Features/Notification/Data/model/NotificationModel.dart';
import 'package:parkingapp/Features/Notification/Presentation/Manager/NotificationState.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitialState());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> getNotifications() async {
    emit(NotificationLoadingState());

    try {
      final user = auth.currentUser;

      if (user == null) {
        emit(
          NotificationErrorState(
            "User is not logged in.",
          ),
        );
        return;
      }

      final QuerySnapshot snapshot = await firestore
          .collection("notifications")
          .where(
            "userId",
            isEqualTo: user.uid,
          )
          .get();

      final List<NotificationModel> notifications =
          snapshot.docs.map((doc) {
        final Map<String, dynamic> data =
            doc.data() as Map<String, dynamic>;

        return NotificationModel.fromJson(data);
      }).toList();

      emit(
        NotificationLoadedState(
          notifications,
        ),
      );
    } catch (e) {
      emit(
        NotificationErrorState(
          e.toString(),
        ),
      );
    }
  }
}