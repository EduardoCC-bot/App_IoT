// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyectoiot/models/registry.dart';
import 'package:proyectoiot/models/user_model.dart';

//------------------------------------------------------------
//Clase encargada del proceso de autenticación (login, register, logout)
//------------------------------------------------------------

class AuthService{

  //Singleton para solo tener una instancia
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Registry? tempRegistry;

  void storeRegistryTemporarily(Registry registry){
    tempRegistry = registry;
  }

  //crea un usuario modelo a partir del objeto de firebase
  UserModel? _userFromFirebaseUser(User? user){
    if (user == null && tempRegistry==null) {
      tempRegistry = null;
      return null;
    } else {
      var userModel = UserModel();
      userModel.uid = user!.uid;
      userModel.apellidoMaterno = tempRegistry?.apm;//borrar en un futuro
      userModel.apellidoPaterno = tempRegistry?.app;//borrar en un futuro
      userModel.casa = tempRegistry?.houseDescription;//borrar en un futuro
      userModel.correo = tempRegistry?.email;//borrar en un futuro
      userModel.edad = tempRegistry?.age;//borrar en un futuro
      userModel.nombre = tempRegistry?.name;//borrar en un futuro
      tempRegistry = null;
      return userModel;
    }
  }


  //corriente de cambios en autenticacion del usuario
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //registrarse por email y contraseña
  Future registerWithEmailAndPassword(Registry registry) async {
    try{
      storeRegistryTemporarily(registry);
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: registry.email!, password: registry.password!);
      User? user = result.user;
      if(user != null) {
        registry.uidDb = user.uid;
      }
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //ingresar por email y contraseña
  Future logInWithEmailAndPassword(Registry tempRegistry) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: tempRegistry.email!, password: tempRegistry.password!);
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