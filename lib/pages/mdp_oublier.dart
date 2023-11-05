import 'package:flutter/material.dart';
import 'package:service_pay_client/widget/bouton.dart';

class MdpOublier extends StatefulWidget {
  const MdpOublier({super.key});

  @override
  State<MdpOublier> createState() => _MdpOublierState();
}

class _MdpOublierState extends State<MdpOublier> {
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
                    Navigator.pushNamed(context, "connexion");
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              const Text(
                "Moe de passe oublier !",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "Baloo",
                    fontSize: 40,
                    color: Colors.white),
              ),
              const Text(
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
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const TextField(
                          decoration: InputDecoration(
                              hintText: "Email...",
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
                  height: 20,
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
                        child: const TextField(
                          decoration: InputDecoration(
                              hintText: "Nouveau mot de passe...",
                              hintStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.grey,
                                  fontFamily: "Baloo",
                                  fontSize: 18),
                              border: InputBorder.none),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const TextField(
                          decoration: InputDecoration(
                              hintText: "Comfirmer le nouveau mot de passe...",
                              hintStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis,
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
              ],
            )),
          ),
        )
      ]),
    ));
  }
}
