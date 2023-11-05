import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'dart:math';

import 'package:service_pay_client/backend/laravel.dart';
import 'package:service_pay_client/pages/codeotp.dart';
import 'package:service_pay_client/widget/bouton.dart';



//import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  TextEditingController nomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController comfirmePassController = TextEditingController();

  _inscription() async {
    int min = 1000;
    int max = 9999;
    final random = Random();
    int otp = min + random.nextInt(max - min);

    var infoClient = {
      'nom_client': nomController.text,
      'email': emailController.text,
      'mot_de_passe': passController.text,
      'code_otp': otp.toString(),
    };

    var resultat =
        await ConnexionLaravel().inscription(infoClient, 'validerdonnee');

    //var body = json.decode(resultat.body);
    if (resultat.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CodeOTP(
                    nom: nomController.toString(),
                    email: emailController.toString(),
                    password: passController.toString(),
                    otp: otp.toString(),
                  )));

      //_encoimail(emailController.toString(), otp.toString());
    } else if (resultat.statusCode == 422) {
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        confirmBtnColor: const Color.fromARGB(255, 42, 12, 79),
        title: "ERREUR",
        text: "Impossible de crée un compte avec cette adresse mail !",
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
                "Inscription",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "Baloo",
                    fontSize: 40,
                    color: Colors.white),
              ),
              Text(
                "Soyez la bienvenue !",
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
                          controller: nomController,
                          decoration: const InputDecoration(
                              hintText: "Nom & Prenom...",
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
                        decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        child: TextField(
                          controller: emailController,
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
                        decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        child: TextField(
                          controller: passController,
                          decoration: const InputDecoration(
                              hintText: "Mot de passe...",
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
                          controller: comfirmePassController,
                          decoration: const InputDecoration(
                              hintText: "Comfirme mot de passe...",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Baloo",
                                  fontSize: 18),
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MonBouton(
                    textecolor: Colors.white,
                    action: () {
                      //Navigator.pushNamed(context, "codeotp");
                      if (passController.text.isEmpty ||
                          comfirmePassController.text.isEmpty ||
                          nomController.text.isEmpty ||
                          emailController.text.isEmpty) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          title: 'ATTENTION',
                          text:
                              'Remplicez tous les champs avant de soumettre le formulaire',
                          confirmBtnColor:
                              const Color.fromARGB(255, 42, 12, 79),
                        );
                      } else if (passController.text ==
                              comfirmePassController.text &&
                          passController.text.length == 8) {
                        _inscription();
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          title: 'ATTENTION',
                          text:
                              'vos mot de passe doivent être indentique avec au moins 8 caractère !',
                          confirmBtnColor:
                              const Color.fromARGB(255, 42, 12, 79),
                        );
                      }
                      //Navigator.pop(context, MaterialPageRoute(builder: (context) => CodeOTP(nom: nom, email: email, password: password)))
                    },
                    btntexte: "S'inscrire",
                    btncolor: const Color.fromARGB(255, 42, 12, 79)),
                const SizedBox(
                  height: 20,
                ),
                MonBouton(
                    textecolor: Colors.black,
                    action: () {
                      Navigator.pushNamed(context, "connexion");
                    },
                    btntexte: "Se connecter",
                    btncolor: Colors.white)
              ],
            )),
          ),
        )
      ]),
    ));
  }
}
