import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Store1FirebaseUser {
  Store1FirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

Store1FirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Store1FirebaseUser> store1FirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Store1FirebaseUser>((user) => currentUser = Store1FirebaseUser(user));
