import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoiot/models/house_info.dart';
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
  HouseInfo? houseInfo;
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
      // Crea una instancia temporal de HouseInfo solo después de actualizar userInfo
      UserInfo tempUserInfo = UserInfo();
      tempUserInfo.updateFromApi(userData);

      HouseInfo tempHouseInfo = HouseInfo(idCasa: tempUserInfo.pkCasa!);
      await tempHouseInfo.obtenerEspacios(replaceSpaces(tempUserInfo.casa!));
      Map<String, dynamic> homeData = await getHouseInfo(tempUserInfo.pkCasa!);
      Map<String, List<dynamic>> homeuserinfo = await getusersHouse(tempUserInfo.pkCasa!);
      List<String> catrol = await getCatrol();

      tempHouseInfo.updateFromApi(homeData);
      tempHouseInfo.updateHomeusers(homeuserinfo, catrol);
      
      setState(() {
        // Actualiza userInfo y houseInfo dentro de setState
        userInfo = tempUserInfo;
        houseInfo = tempHouseInfo;
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
    print(userInfo);
    print(houseInfo); 

    return loading ? const Loading() : MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: userInfo),
        ChangeNotifierProvider.value(value: houseInfo!),
      ],
      child: Consumer<HouseInfo>(
        builder: (context, houseInfo, child) {
          int tabLength = houseInfo.espacios.isNotEmpty ? houseInfo.espacios.length : 1;
          return Scaffold(
            backgroundColor: colorBlanco,
            drawer: AppDrawer(onDrawerItemTapped: onDrawerItemTapped),
            appBar: AppBar(
              title: Text(header),
              centerTitle: true,
              backgroundColor: color_1,
              elevation: 5.0,
            ),
            floatingActionButton: floatingButton, 
            body: DefaultTabController(
              length: tabLength,
              child: buildScreen(),
            ),
          );
        },
      ),
    );
  }
}
