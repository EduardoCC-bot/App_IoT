import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyectoiot/models/user_model.dart';

//------------------------------------------------------------
//Clase encargada del proceso de autenticación (login, register, logout)
//------------------------------------------------------------

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  //crea un usuario modelo a partir del objeto de firebase
  UserModel? _userFromFirebaseUser(User? user){
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //corriente de cambios en autenticacion del usuario
  Stream<UserModel?> get user {
    return _auth.authStateChanges()
    .map(_userFromFirebaseUser);
  }

  //registrarse por anónimo
  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      if (result.user != null) {
        UserModel? user = _userFromFirebaseUser(result.user!);
        return user;
      } else{
        return null;
      }
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  //registrarse por email y contraseña
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user; 
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //ingresar por email y contraseña
  Future logInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user; 
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //salir
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}