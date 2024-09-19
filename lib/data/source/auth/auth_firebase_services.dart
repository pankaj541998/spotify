import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_bloc/core/configs/constant/app_urls.dart';
import 'package:spotify_bloc/data/models/auth/user_model.dart';
import 'package:spotify_bloc/domain/entities/auth/user.dart';

import '../../models/auth/create_user_auth_modal.dart';
import '../../models/auth/signin_auth_model.dart';

abstract class AuthFirebaseService {
  Future<Either> signUp(CreateUserRequest createUserRequest);
  Future<Either> signIn(SigninRequestUser signinRequestUser);
  Future<Either> getUser();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signIn(SigninRequestUser signinRequestUser) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinRequestUser.email,
        password: signinRequestUser.password,
      );

      return const Right("Signin was successfull");
    } on FirebaseAuthException catch (e) {
      String messgae = "";
      if (e.code == 'user-not-found') {
        messgae = "User not found";
      } else if (e.code == 'invalid-email') {
        messgae = "Invalid email";
      } else if (e.code == 'invalid-credential') {
        messgae = "Invalid credentials";
      }
      return Left(messgae);
    }
  }

  @override
  Future<Either> signUp(CreateUserRequest createUserRequest) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserRequest.email,
        password: createUserRequest.password,
      );
      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': createUserRequest.username,
        'email': data.user!.email,
      });

      return const Right("Sign Up");
    } on FirebaseException catch (e) {
      String message = "";
      if (e.code == "weak-password") {
        message = "This password provided is too weak.";
      } else if (e.code == "email-already-in-use") {
        message = "This eamil is already in use.";
      }

      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageURL =
          firebaseAuth.currentUser?.photoURL ?? AppURLs.defaultImage;
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return const Left("Something went wrong");
    }
  }
}
