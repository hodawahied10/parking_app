import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:parkingapp/Core/model/User_Model.dart';
import 'package:parkingapp/Features/Profile/Presentation/Manager/ProfileState.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState()) {
    getUserData();
  }

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  // Empty user data until real data is loaded
  UserModel user = UserModel(name: "", email: "", phone: "", uid: "");

  int totalBookings = 0;

  String memberSince = "";

  // Temporary profile image path
  String? imagePath;

  // =========================
  // Pick Profile Image
  // =========================

  Future<void> pickProfileImage() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image == null) {
        return;
      }

      imagePath = image.path;

      final ProfileState currentState = state;

      if (currentState is ProfileSuccessState) {
        emit(
          ProfileSuccessState(
            currentState.user,
            currentState.totalBookings,
            currentState.memberSince,
            imagePath: imagePath,
          ),
        );
      }
    } catch (e) {
      emit(ProfileErrorState("Failed to select profile image"));
    }
  }

  // =========================
  // Get User Data
  // =========================

  Future<void> getUserData() async {
    emit(ProfileLoadingState());

    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;

      // No logged-in user
      if (currentUser == null) {
        emit(
          ProfileSuccessState(
            user,
            totalBookings,
            memberSince,
            imagePath: imagePath,
          ),
        );
        return;
      }

      // Get user data from Firestore
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("user")
          .doc(currentUser.uid)
          .get();

      // If user document exists, get the real data
      if (userDoc.exists) {
        final Map<String, dynamic> data =
            userDoc.data() as Map<String, dynamic>;

        user = UserModel.fromJson(data);

        // Fill Edit Profile fields
        nameController.text = user.name;
        emailController.text = user.email;
        phoneController.text = user.phone;
      }

      // Get total bookings for current user
      final QuerySnapshot bookingsSnapshot = await FirebaseFirestore.instance
          .collection("bookings")
          .where("userId", isEqualTo: currentUser.uid)
          .get();

      totalBookings = bookingsSnapshot.docs.length;

      // Get account creation date
      final DateTime? creationDate = currentUser.metadata.creationTime;

      memberSince = creationDate != null ? formatMemberSince(creationDate) : "";

      // Keep the selected image path
      // while refreshing profile data
      emit(
        ProfileSuccessState(
          user,
          totalBookings,
          memberSince,
          imagePath: imagePath,
        ),
      );
    } catch (e) {
      // Keep the Profile UI visible even if loading fails
      emit(
        ProfileSuccessState(
          user,
          totalBookings,
          memberSince,
          imagePath: imagePath,
        ),
      );
    }
  }

  // =========================
  // Update Profile
  // =========================

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    // =========================
    // Validation
    // =========================

    final String newName = name.trim();
    final String newEmail = email.trim();
    final String newPhone = phone.trim();

    if (newName.isEmpty) {
      emit(ProfileErrorState("Please enter your full name"));
      return;
    }

    if (newEmail.isEmpty) {
      emit(ProfileErrorState("Please enter your email address"));
      return;
    }

    if (newPhone.isEmpty) {
      emit(ProfileErrorState("Please enter your phone number"));
      return;
    }

    // =========================
    // Loading
    // =========================

    emit(ProfileLoadingState());

    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        emit(ProfileErrorState("No user is currently logged in"));
        return;
      }

      final String currentEmail = currentUser.email?.trim() ?? "";

      // =========================
      // Update Firebase Auth Email
      // =========================

      if (newEmail.isNotEmpty && newEmail != currentEmail) {
        await currentUser.verifyBeforeUpdateEmail(newEmail);
      }

      // =========================
      // Update Firestore
      // =========================

      await FirebaseFirestore.instance
          .collection("user")
          .doc(currentUser.uid)
          .update({"name": newName, "email": newEmail, "phone": newPhone});

      // =========================
      // Reload Profile Data
      // =========================

      await getUserData();
    } on FirebaseAuthException catch (e) {
      String message = "Failed to update profile";

      if (e.code == "requires-recent-login") {
        message = "Please log in again before changing your email";
      } else if (e.code == "email-already-in-use") {
        message = "This email is already in use";
      } else if (e.code == "invalid-email") {
        message = "Please enter a valid email address";
      }

      emit(ProfileErrorState(message));
    } catch (e) {
      emit(ProfileErrorState("Failed to update profile"));
    }
  }

  // =========================
  // Save Edited Profile Data
  // =========================

  Future<void> onSaveProfile(String name, String email, String phone) async {
    await updateProfile(name: name, email: email, phone: phone);
  }

  // =========================
  // Format Member Since
  // =========================

  String formatMemberSince(DateTime date) {
    const List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];

    return "${months[date.month - 1]} ${date.year}";
  }

  // =========================
  // Dispose
  // =========================

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    return super.close();
  }
}
