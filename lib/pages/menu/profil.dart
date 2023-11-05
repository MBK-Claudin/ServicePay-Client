import 'dart:async';
import 'dart:convert';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:service_pay_client/backend/laravel.dart';

class Profil extends StatefulWidget {
  final Map<String, dynamic> client;

  const Profil({Key? key, required this.client}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  Map<String, dynamic> clientData = {};
  TextEditingController nom = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataPeriodically();
  }

  Future<void> fetchData() async {
    String id = widget.client['id'].toString();

    final String apiUrl =
        'http://10.0.2.2:8000/api/recupeclient/$id'; // Remplacez par votre URL

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (mounted) {
        setState(() {
          clientData = data['client'];
          // ignore: avoid_print
          print(clientData);
        });
      }
    } else {
      if (mounted) {
        setState(() {
          clientData = {'error': 'Erreur: ${response.statusCode}'};
        });
      }
    }
  }

  _modifNOM() async {
    var data = {
      'nom': nom.text,
    };
    String id = widget.client['id'].toString();

    var resultat =
        await ConnexionLaravel().modifierNOM(data, 'modifiernom/$id');

    //var body = json.decode(resultat.body);
    if (resultat.statusCode == 200) {
      // ignore: avoid_print
      print("ok !");

      //_encoimail(emailController.toString(), otp.toString());
    } else if (resultat.statusCode == 422) {
      // ignore: avoid_print
      print("object");
    } else {
      // ignore: avoid_print
      print("bad");
    }
  }

  void fetchDataPeriodically() {
    fetchData();

    Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 180,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 42, 12, 79)),
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: Colors.white),
                      ))
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage("assets/images/user.png")),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    "Nom & Prenom",
                    style: TextStyle(fontFamily: "Baloo", fontSize: 20),
                  ),
                  subtitle: Text(
                    "${clientData['nom_client']}",
                    style: const TextStyle(fontFamily: "Baloo", fontSize: 18),
                  ),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    showPlatformDialog(
                      context: context,
                      builder: (_) => BasicDialogAlert(
                        title: const Text("Saisir vos nom & prenom"),
                        content: Container(
                          alignment: Alignment.center,
                          height: 80,
                          child: Column(
                            children: [
                              TextField(
                                controller: nom,
                                decoration: InputDecoration(
                                    labelText: clientData['nom_client'],
                                    border: const UnderlineInputBorder()),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          BasicDialogAction(
                            title: const Text(
                              "Valider",
                              style: TextStyle(
                                  fontFamily: "Baloo",
                                  fontSize: 18,
                                  color: Colors.lightGreen),
                            ),
                            onPressed: () {
                              _modifNOM();
                              Navigator.pop(context);
                            },
                          ),
                          BasicDialogAction(
                            title: const Text(
                              "Annuler",
                              style: TextStyle(
                                  fontFamily: "Baloo",
                                  fontSize: 16,
                                  color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(
                  color: Colors.black,
                ),
                ListTile(
                  title: const Text(
                    "mot de passe",
                    style: TextStyle(fontFamily: "Baloo", fontSize: 20),
                  ),
                  subtitle: const Text(
                    "********",
                    style: TextStyle(fontFamily: "Baloo", fontSize: 18),
                  ),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    showPlatformDialog(
                      context: context,
                      builder: (_) => BasicDialogAlert(
                        title: const Text("modifier votre mot de passe"),
                        content: Container(
                          alignment: Alignment.center,
                          height: 120,
                          child: const Column(
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                    hintText: "Nouveau mot de passe",
                                    hintStyle: TextStyle(
                                        fontFamily: "Baloo",
                                        fontSize: 16,
                                        color: Colors.grey),
                                    border: UnderlineInputBorder()),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: "Nouveau mot de passe",
                                    hintStyle: TextStyle(
                                        fontFamily: "Baloo",
                                        fontSize: 16,
                                        color: Colors.grey),
                                    border: UnderlineInputBorder()),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          BasicDialogAction(
                            title: const Text(
                              "Valider",
                              style: TextStyle(
                                  fontFamily: "Baloo",
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 42, 12, 79)),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          BasicDialogAction(
                            title: const Text(
                              "Annuler",
                              style: TextStyle(
                                  fontFamily: "Baloo",
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 42, 12, 79)),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(
                  color: Colors.black,
                ),
                ListTile(
                  title: const Text(
                    "Email",
                    style: TextStyle(fontFamily: "Baloo", fontSize: 20),
                  ),
                  subtitle: Text(
                    "${clientData['email']}",
                    style: const TextStyle(fontFamily: "Baloo", fontSize: 18),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
