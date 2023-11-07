import 'package:flutter/material.dart';

final choosingIcon = Container (
  width: 200,
  height: 200,
  margin: const EdgeInsets.only(top: 20, bottom: 20),
  child : ClipRRect(
      child: Center(
        child: Image.asset("images/idea.png"),
      ),
  ),
);