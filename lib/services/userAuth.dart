import 'dart:io';
import 'package:ayurbot/services/messageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:ayurbot/services/userModel.dart';

class UserAuth {
  FirebaseAuth _fireAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  User? getCurrentUser() {
    return _fireAuth.currentUser;
  }

  registerUser({
    required UserModel userModel,
  }) async {
    if (userModel.email != "" &&
        userModel.password != "" &&
        userModel.name != "") {
      try {
        UserCredential registerCredentials =
            await _fireAuth.createUserWithEmailAndPassword(
          email: userModel.email,
          password: userModel.password,
        );
        User? user = registerCredentials.user;
        if (user != null) {
          _saveUser(userData: userModel.toMap());
          print("User Created successfully✔");
          //return true; for successfully logged in
        }
      } on FirebaseAuthException catch (err) {
        print("while registering user\nfound: ${err.code}");
        return null;
      }
    } else {
      print("please fill all the fields");
    }
  }

  _saveUser({
    required Map<String, dynamic> userData,
  }) {
    try {
      _firestore.collection("users").doc(getCurrentUser()!.uid).set(userData);
      print("user details registred ✅");
    } catch (err) {
      print("while saving user data\nfound error: $err");
    }
  }

  saveChat({
    required List<Map<String, dynamic>> msgs,
  }) {
    Map<String, dynamic> chat = {
      "msgs": msgs,
    };
    try {
      _firestore.collection("messages").doc(getCurrentUser()!.uid).set(chat);
      print("chat stored ✅");
    } catch (err) {
      print("while saving user chat\nfound error: $err");
    }
  }

  retrieveChat() async {
    User? currUser = getCurrentUser();
    try {
      print("yes retreive");
      CollectionReference coll = _firestore.collection("messages");
      DocumentReference doc = coll.doc(currUser!.uid);
      DocumentSnapshot docSnapshot = await doc.get();

      print("Displaying user's chat");
      print(docSnapshot.data());
      return docSnapshot.data();
    } catch (err) {
      print("While retrieving data\nfound error: ${err}");
    }
  }

  selectImage({required List<dynamic> paths, required ImageSource src}) async {
    try {
      XFile? selectedImg = await ImagePicker().pickImage(source: src);

      if (selectedImg != null) {
        File convertedImg = File(selectedImg.path);
        paths.add(convertedImg);
      } else {
        print("No image selected");
      }
      return paths;
    } catch (err) {
      print("while selecting image\nfound error: $err");
    }
  }

  Future<List<String>> _storeImg({
    required List<dynamic> images,
  }) async {
    try {
      List<Future<String>> downloadURLs = images.map((img) async {
        if ("${img.runtimeType}" == "_File") {
          UploadTask uploadTask = _storage
              .ref()
              .child("Images")
              .child(getCurrentUser()!.uid)
              .child(Uuid().v1())
              .putFile(img);

          TaskSnapshot taskSnapshot = await uploadTask;
          String downloadURL = await taskSnapshot.ref.getDownloadURL();
          print("in file zone downloadUrl is: $downloadURL");
          return downloadURL;
        } else {
          return "$img";
        }
      }).toList();
      List<String> downloadurls = await Future.wait(downloadURLs);
      print("images stored ✅");
      return downloadurls;
    } catch (err) {
      print("while storing images\nfound error: ${err}");
      return [];
    }
  }

  signInUser({required String email, required String password}) async {
    try {
      UserCredential signInCredentials = await _fireAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = signInCredentials.user;
      return user;
    } on FirebaseAuthException catch (err) {
      print("while signing in\nfound error: ${err.code}");
    }
  }

  signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();

    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _fireAuth.signInWithCredential(credential);
      UserModel userModel = UserModel.fromMap({
        'email': googleUser.email,
        'password': "",
        'name': googleUser.displayName ?? "",
        'profilePicUrl': googleUser.photoUrl,
      });
      _saveUser(userData: userModel.toMap());
      return true;
    } catch (err) {
      print("while signing in with Google\nfound error: ${err}");
    }
  }

  signOutUser() async {
    try {
      await _fireAuth.signOut();
    } on FirebaseAuthException catch (err) {
      print("while signingOut\nfound error: ${err.code}");
    }
  }
}
