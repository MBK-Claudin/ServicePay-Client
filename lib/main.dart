import 'package:flutter/material.dart';
import 'package:service_pay_client/pages/accueil.dart';
import 'package:service_pay_client/pages/codeotp.dart';
import 'package:service_pay_client/pages/connexion.dart';
//import 'package:service_pay_client/pages/home.dart';
import 'package:service_pay_client/pages/inscription.dart';
import 'package:service_pay_client/pages/mdp_oublier.dart';
import 'package:service_pay_client/pages/menu/suggestion.dart';
//import 'package:service_pay_client/pages/menu/envoi_demande.dart';
//import 'package:service_pay_client/pages/menu/service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.purple.shade900),
      routes: {
        "/": (context) => const Accueil(),
        "Inscription": (context) => const Inscription(),
        "connexion": (context) => const Connexion(),
        "codeotp": (context) => const CodeOTP(),
        //"home": (context) => const Home(),
        //"service": (context) => const Service(),
        //"envoidemande":(context) => const EnvoiDemande(),
        "oublier": (context) => const MdpOublier(),
        "suggestion": (context) => const Suggestions(),
      },
    );
  }
}
