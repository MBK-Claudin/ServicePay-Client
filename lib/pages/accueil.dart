import 'package:flutter/material.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(children: [
        Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 42, 12, 79),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(190))),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bienvenue sur",
                    style: TextStyle(
                        fontFamily: "Baloo",
                        fontSize: 40,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                  Text(
                    "ServicePay",
                    style: TextStyle(
                        fontFamily: "Baloo",
                        fontSize: 50,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
            )),
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Découvrez une nouvelle façon pratique de payer des services professionnels directement depuis  votre téléphone avec notre application mobile intuitive.",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: "Baloo",
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 42, 12, 79),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "Inscription");
                      },
                      child: const Text(
                        "Continuer",
                        style: TextStyle(
                            fontFamily: "Baloo",
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ))
      ]),
    ));
  }
}
