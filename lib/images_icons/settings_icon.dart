import 'package:flutter/material.dart';



final settingsIcon = Container (
  width: 180,
  height: 180,
  margin: const EdgeInsets.only(top: 0, bottom: 20),
  child : ClipRRect(
      child: Center(
        child: Image.network("https://cdn-icons-png.flaticon.com/512/771/771203.png"),
      ),
  ),
);
