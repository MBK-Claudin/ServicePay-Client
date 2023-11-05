import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:service_pay_client/backend/laravel.dart';
import 'package:service_pay_client/pages/home.dart';
// import 'package:service_pay_client/pages/home.dart';
import 'package:service_pay_client/widget/bouton.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  TextEditingController email = TextEditingController();
  TextEditingController mdp = TextEditingController();

  _connexion() async {
    var infoClient = {
      'email': email.text,
      'mot_de_passe': mdp.text,
    };

    var response = await ConnexionLaravel().connexion(infoClient, 'connexion');

    var response1 = await ConnexionLaravel().allService('AllService');

    //var body = json.decode(resultat.body);
    if (response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic> services = jsonDecode(response1.body);
      // ignore: avoid_print
      print(services['service']);
      // ignore: avoid_print
      print(data);

      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        confirmBtnColor: const Color.fromARGB(255, 42, 12, 79),
        title: "Succès",
        text: "Connexion valider !",
        onConfirmBtnTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        services: services['service'],
                        clientdata: data['client'],
                      )));
        },
      );
    } else if (response.statusCode == 422) {
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        confirmBtnColor: const Color.fromARGB(255, 42, 12, 79),
        title: "ERREUR",
        text: "Veuillez entrer une adresse mail valide !",
      );
    } else {
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        confirmBtnColor: const Color.fromARGB(255, 42, 12, 79),
        title: "ERREUR",
        text: "Echec de connexion",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 42, 12, 79)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 80,
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Connexion",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "Baloo",
                    fontSize: 40,
                    color: Colors.white),
              ),
              Text(
                "Bon retour !",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "Baloo",
                    fontSize: 20,
                    color: Colors.white),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.purple.shade300,
                            blurRadius: 10,
                            offset: const Offset(0, (5)))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        child: TextField(
                          controller: email,
                          decoration: const InputDecoration(
                              hintText: "Email...",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Baloo",
                                  fontSize: 18),
                              border: InputBorder.none),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: mdp,
                          decoration: const InputDecoration(
                              hintText: "Mot de passe...",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Baloo",
                                  fontSize: 18),
                              border: InputBorder.none),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MonBouton(
                    textecolor: Colors.black,
                    action: () {
                      Navigator.pushNamed(context, "oublier");
                    },
                    btntexte: "Mot de passe oublier ?",
                    btncolor: Colors.white),
                const SizedBox(
                  height: 10,
                ),
                MonBouton(
                    textecolor: Colors.white,
                    action: () {
                      if (email.text.isEmpty || mdp.text.isEmpty) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          confirmBtnColor:
                              const Color.fromARGB(255, 42, 12, 79),
                          title: "Attention",
                          text:
                              "Remplissez tous les avant de valider votre formulaire !",
                        );
                      } else if (mdp.text.length >= 8) {
                        _connexion();
                      }
                      //Navigator.pushNamed(context, "home");
                    },
                    btntexte: "Se connecter",
                    btncolor: const Color.fromARGB(255, 42, 12, 79)),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Créer votre comptes",
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: "Baloo",
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis),
                ),
                MonBouton(
                    textecolor: Colors.black,
                    action: () {
                      Navigator.pushNamed(context, "Inscription");
                    },
                    btntexte: "S'inscripre ?",
                    btncolor: Colors.white)
              ],
            )),
          ),
        )
      ]),
    ));
  }
}
