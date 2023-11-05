import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:service_pay_client/backend/laravel.dart';
import 'package:service_pay_client/widget/bouton.dart';

class EnvoiDemande extends StatefulWidget {
  final int idclient;
  final int idservice;
  const EnvoiDemande(
      {super.key, required this.idclient, required this.idservice});

  @override
  State<EnvoiDemande> createState() => _EnvoiDemandeState();
}

class _EnvoiDemandeState extends State<EnvoiDemande> {
  TextEditingController dateDebut = TextEditingController();
  TextEditingController dateFin = TextEditingController();
  TextEditingController adresse = TextEditingController();

  _demandeService() async {
    var data = {
      'date_debut': dateDebut.text,
      'date_fin': dateFin.text,
      'adresse': adresse.text,
    };
    String idcl = widget.idclient.toString();
    String idser = widget.idservice.toString();

    var resultat = await ConnexionLaravel()
        .demandeService(data, 'demandeService/$idcl/$idser');

    //var body = json.decode(resultat.body);
    if (resultat.statusCode == 200) {
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        confirmBtnColor: const Color.fromARGB(255, 42, 12, 79),
        title: "Succès",
        text: "Demande envoyer",
        onConfirmBtnTap: () {
          dateDebut.clear();
          dateFin.clear();
          adresse.clear();
        },
      );

      //_encoimail(emailController.toString(), otp.toString());
    } else if (resultat.statusCode == 422) {
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        confirmBtnColor: const Color.fromARGB(255, 42, 12, 79),
        title: "ERREUR",
        text: "Veuillez entrer un modèle de date valide: jj/mm/aaaa",
        onConfirmBtnTap: () {
          dateDebut.clear();
          dateFin.clear();
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        confirmBtnColor: const Color.fromARGB(255, 42, 12, 79),
        title: "ERREUR",
        text: "Echec de connexion",
        onConfirmBtnTap: () {
          dateDebut.clear();
          dateFin.clear();
          adresse.clear();
        },
      );
    }
  }

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
              const Text(
                "Remplicez le formulaire",
                overflow: TextOverflow.clip,
                style: TextStyle(fontFamily: "Baloo", fontSize: 22),
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
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      child: TextField(
                        controller: dateDebut,
                        decoration: const InputDecoration(
                            hintText: "date de debut...",
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
                        controller: dateFin,
                        decoration: const InputDecoration(
                            hintText: "Date de fin...",
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
                        controller: adresse,
                        decoration: const InputDecoration(
                            hintText: "Adresse...",
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
                height: 40,
              ),
              MonBouton(
                  action: () {
                    if (dateDebut.text.isEmpty ||
                        dateFin.text.isEmpty ||
                        adresse.text.isEmpty) {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        confirmBtnColor: const Color.fromARGB(255, 42, 12, 79),
                        title: "ERREUR",
                        text:
                            "remplissez tous les champs avant de soumettre votre formulaire",
                      );
                    } else {
                      _demandeService();
                    }
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
