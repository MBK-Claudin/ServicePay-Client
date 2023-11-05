import 'package:flutter/material.dart';

class MonBouton extends StatelessWidget {
  final VoidCallback action;
  final String btntexte;
  final Color btncolor, textecolor;

  const MonBouton({
    super.key,
    required this.action,
    required this.btntexte,
    required this.btncolor,
    required this.textecolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 230,
      height: 50,
      decoration: BoxDecoration(
          color: btncolor, borderRadius: BorderRadius.circular(30)),
      child: TextButton(
        onPressed: action,
        child: Text(
          btntexte,
          style:
              TextStyle(fontFamily: "Baloo", fontSize: 20, color: textecolor),
        ),
      ),
    );
  }
}
