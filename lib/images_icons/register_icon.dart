import 'package:flutter/material.dart';



final registerIcon = Container (
  width: 180,
  height: 180,
  margin: const EdgeInsets.only(top: 0, bottom: 20),
  child : ClipRRect(
      child: Center(
        child: Image.network("https://cdn-icons-png.flaticon.com/512/3534/3534138.png"),
      ),
  ),
);

