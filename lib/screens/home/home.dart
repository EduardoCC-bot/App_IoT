import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoiot/screens/home/settings_screen.dart';
import 'package:proyectoiot/shared/widget_functions.dart';
import 'package:proyectoiot/special_widgets/floating_button.dart';
import '../../models/user_info.dart';
import '../../models/user_model.dart';
import '../../shared/constants.dart';
import '../../shared/sql_functions.dart';
import '../../special_widgets/drawer_menu.dart';
import '../loading.dart';
import 'mainly_screen.dart';
import 'notification_screen.dart';
//------------------------------------------------------------
//HOME. Pantalla contenedora a la que se accede una vez autentificado
//------------------------------------------------------------

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {

  int selectedDrawerItem = 0;
  String header='Inicio';
  Widget? floatingButton;
  UserInfo userInfo = UserInfo();
  bool loading = true;

  void onDrawerItemTapped(int itemIndex) {
  setState(() {
    selectedDrawerItem = itemIndex;
    header = getAppBarTitle(itemIndex);
    floatingButton = (itemIndex == 0) ? AddAreaDevice(context: context) : null;
  });
  }

  @override
  void initState() {
    super.initState();
    selectedDrawerItem = 0;
    floatingButton = AddAreaDevice(context: context);
    initUserData();
  }

  void initUserData() async {
    final user = Provider.of<UserModel?>(context, listen: false);

    if (user != null && user.uid != null) {
      await verifyAndGetData(user.uid!);
    }
  }

  Future<void> verifyAndGetData(String uid) async {
    Map<String, dynamic> userData = await getUserInfo(uid);
      
    if (userData.isNotEmpty && userData['nombre'] != null) {
      setState(() {
        userInfo.updateFromApi(userData);
        loading = false;
      });
    } else {
      await Future.delayed(const Duration(milliseconds: 600));
      await verifyAndGetData(uid); // Reintenta obtener los datos
    }
  }

  Widget buildScreen() {
    switch(selectedDrawerItem){
      case 0:
        return const PrincipalScreen();
      case 1:
        return const NotificationScreen();
      case 2:
        return const Settings();
      default:
        return const Center(child: Text('Opción no válida'));
    }
  }

  @override
  Widget build(BuildContext context) {    
    return loading ? const Loading() : ChangeNotifierProvider.value(
      value: userInfo,
      child: DefaultTabController(
        length: 6,
        child: Scaffold(
          backgroundColor: colorBlanco,
          drawer: AppDrawer(onDrawerItemTapped: onDrawerItemTapped),
          appBar: AppBar(
            title: Text(header),
            centerTitle: true,
            backgroundColor: color_1,
            elevation: 5.0,
          ),
          floatingActionButton: floatingButton, 
          body: buildScreen(),
        ),
      ),
    );
  }
}
