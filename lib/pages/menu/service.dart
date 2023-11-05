import 'package:flutter/material.dart';
import 'package:service_pay_client/pages/menu/envoi_demande.dart';
import 'package:service_pay_client/widget/bouton.dart';

class ServiceView extends StatefulWidget {
  final Map<String, dynamic> service;
  final int idClient;
  const ServiceView({super.key, required this.service, required this.idClient});

  @override
  State<ServiceView> createState() => _ServiceState();
}

class _ServiceState extends State<ServiceView> {
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
      body: ListView(children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30.0),
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              // Block de Titre Services
              Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    const Icon(Icons.work_outline),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.service['intitule'].toString(),
                      style: const TextStyle(
                          fontFamily: "Baloo",
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              // affichage des services
              Container(
                alignment: Alignment.center,
                child: ListTile(
                  title: const Text(
                    "Descriton",
                    style: TextStyle(
                        fontFamily: "Baloo",
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    widget.service['description'].toString(),
                    style: const TextStyle(fontFamily: "Baloo", fontSize: 16),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ListTile(
                  title: const Text(
                    "Tarif",
                    style: TextStyle(
                        fontFamily: "Baloo",
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    widget.service['horaires'].toString(),
                    style: const TextStyle(fontFamily: "Baloo", fontSize: 16),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                child: const ListTile(
                  title: Text(
                    "Horaires",
                    style: TextStyle(
                        fontFamily: "Baloo",
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    "08h - 19h",
                    style: TextStyle(fontFamily: "Baloo", fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MonBouton(
                  action: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EnvoiDemande(
                          idclient: widget.idClient,
                          idservice: widget.service['id'],
                          // Passez les données du service
                        ),
                      ),
                    );
                  },
                  btntexte: "Demande de service",
                  btncolor: const Color.fromARGB(255, 42, 12, 79),
                  textecolor: Colors.white)
            ],
          ),
        )
      ]),
    );
  }
}
