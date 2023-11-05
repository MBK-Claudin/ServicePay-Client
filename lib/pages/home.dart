import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:service_pay_client/pages/menu/home_accueil.dart';
import 'package:service_pay_client/pages/menu/liste_demande.dart';
import 'package:service_pay_client/pages/menu/notification.dart';
import 'package:service_pay_client/pages/menu/profil.dart';
import 'package:service_pay_client/pages/menu/suggestion.dart';

class Home extends StatefulWidget {
  final Map<String, dynamic> clientdata;
  final List<dynamic> services;
  //final Map<String, dynamic> services;
  const Home({super.key, required this.clientdata, required this.services});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selecte = "home";
  String titre = "ServicePay";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 42, 12, 79),
        title: const Text(
          "ServicePay",
          style: TextStyle(
              fontFamily: "Baloo", fontSize: 30, fontWeight: FontWeight.w700),
        ),
      ),
      body: _buildBodyContent(widget.clientdata, widget.services),
      floatingActionButton: SpeedDial(
        backgroundColor: const Color.fromARGB(255, 42, 12, 79),
        activeBackgroundColor: Colors.purple.shade300,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.home),
            label: "Home",
            labelStyle: const TextStyle(fontFamily: "Baloo", fontSize: 18),
            onTap: () {
              setState(() {
                selecte = "home";
              });
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.person),
            label: "Profil",
            labelStyle: const TextStyle(fontFamily: "Baloo", fontSize: 18),
            onTap: () {
              setState(() {
                selecte = "profil";
              });
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.send),
            label: "demande Envoyer",
            labelStyle: const TextStyle(fontFamily: "Baloo", fontSize: 18),
            onTap: () {
              setState(() {
                selecte = "demandes";
              });
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.notifications),
            label: "Notification",
            labelStyle: const TextStyle(fontFamily: "Baloo", fontSize: 18),
            onTap: () {
              setState(() {
                selecte = "notification";
              });
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.logout),
            label: "Déconnexion",
            labelStyle: const TextStyle(fontFamily: "Baloo", fontSize: 18),
            onTap: () {
              Navigator.pushNamed(context, "connexion");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBodyContent(
      Map<String, dynamic> client, List<dynamic> services) {
    if (selecte == "home") {
      return HomeAccueil(
        client: client,
        services: services,
      );
    } else if (selecte == "profil") {
      return Profil(
        client: client,
      );
    } else if (selecte == "notification") {
      return const Notifications();
    } else if (selecte == "demandes") {
      return ListeDemandes(
        client: client,
      );
    } else if (selecte == "suggestion") {
      return const Suggestions();
    }
    return HomeAccueil(
      client: client,
      services: services,
    );
  }
}
