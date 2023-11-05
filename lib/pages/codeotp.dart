import 'package:flutter/material.dart';
import 'package:service_pay_client/widget/bouton.dart';

class CodeOTP extends StatefulWidget {
  final String? nom;
  final String? email;
  final String? password;
  final String? otp;

  const CodeOTP(
      {super.key,
       this.nom,
       this.email,
       this.password,
       this.otp});

  @override
  State<CodeOTP> createState() => _CodeOTPState();
}

class _CodeOTPState extends State<CodeOTP> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "Inscription");
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              const Text(
                "Comfirmer votre compte",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "Baloo",
                    fontSize: 40,
                    color: Colors.white),
              ),
              const Text(
                "Consulter votre boîte mail et saisez le code à quatre chiffre.",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "Baloo",
                    fontSize: 20,
                    color: Colors.white),
                overflow: TextOverflow.clip,
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
                        child: const TextField(
                          decoration: InputDecoration(
                              hintText: "Code de comfirmation...",
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
                    textecolor: Colors.white,
                    action: () {
                      Navigator.pushNamed(context, "home");
                    },
                    btntexte: "Comfirmer",
                    btncolor: const Color.fromARGB(255, 42, 12, 79)),
                const SizedBox(
                  height: 30,
                ),
                MonBouton(
                    textecolor: Colors.black,
                    action: () {},
                    btntexte: "Renvoyer le code",
                    btncolor: Colors.white),
              ],
            )),
          ),
        )
      ]),
    ));
  }
}
