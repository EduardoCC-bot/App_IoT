import 'package:flutter/material.dart';



final logoIcon = Container (
  width: 200,
  height: 200,
  margin: const EdgeInsets.only(top: 20, bottom: 20),
  child : ClipRRect(
      child: Center(
        child: Image.network("https://cdn-icons-png.flaticon.com/512/3354/3354557.png"),
      ),
  ),
);



