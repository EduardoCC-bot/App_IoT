class Registry {
  
  String? email;
  String? password;
  String? rol;
  String? name;
  String? apm;
  String? app;
  int? age;
  String? lada;   //cast to int
  int? telephone;

  String? houseDescription;
  String? houseType;
  String? housePassword;

  String? country;
  String? state;
  String? municipality;
  String? colony;
  String? street;
  String? extNum; //cast to int
  String? intNum; // cast to int 
  String? cp;     //cast to int

  Registry();

  @override
  String toString() {
    return 'UserInformation{'
      'email: $email, '
      'password: $password, '
      'name: $name, '
      'apm: $apm, '
      'app: $app, '
      'age: $age, '
      'lada: $lada, '
      'telephone: $telephone, '
      'houseDescription: $houseDescription, '
      'houseType: $houseType, '
      'housePassword: $housePassword, '
      'country: $country, '
      'state: $state, '
      'municipality: $municipality, '
      'colony: $colony, '
      'street: $street, '
      'extNum: $extNum, '
      'intNum: $intNum, '
      'cp: $cp'
    '}';
  }
}

