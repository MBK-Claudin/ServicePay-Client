import 'dart:async';
import 'dart:convert';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:service_pay_client/backend/laravel.dart';
import 'package:service_pay_client/pages/menu/service.dart';

class HomeAccueil extends StatefulWidget {
  final Map<String, dynamic> client;
  final List<dynamic> services;

  const HomeAccueil({Key? key, required this.client, required this.services})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeAccueilState createState() => _HomeAccueilState();
}

class _HomeAccueilState extends State<HomeAccueil> {
  TextEditingController message = TextEditingController();
  Map<String, dynamic> clientData = {};

  @override
  void initState() {
    super.initState();
    fetchDataPeriodically();
  }

  Future<void> recuperclient() async {
    String id = widget.client['id'].toString(); // Remplacez par votre URL

    final response = await ConnexionLaravel().recupeClient('recupeclient/$id');

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

  Future<void> envoiSuggestion() async {
    String id = widget.client['id'].toString();

    var info = {
      'client_id': id,
      'conyenu': message.text,
    };

    final response =
        await ConnexionLaravel().envoiSuggestion(info, 'envoiSuggestion/$id');

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

  void fetchDataPeriodically() {
    recuperclient();

    Timer.periodic(const Duration(seconds: 10), (timer) {
      recuperclient();
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
                          width: 320,
                          height: 100,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.purple.shade300,
                                    blurRadius: 10,
                                    offset: const Offset(0, (5)))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(
                              "${clientData['nom_client']}",
                              style: const TextStyle(
                                  fontFamily: "Baloo", fontSize: 20),
                            ),
                            subtitle: Text(
                              "${clientData['email']}",
                              style: const TextStyle(
                                  fontFamily: "Baloo", fontSize: 18),
                            ),
                            trailing: Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/user.png"))),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () {
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
                                controller: message,
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
                              envoiSuggestion();
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
                  icon: const Icon(Icons.send)),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "envoyer un suggestion",
                style: TextStyle(
                  fontFamily: "Baloo",
                  fontSize: 16,
                ),
              )
            ],
          ),
          const Divider(
            color: Colors.black,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: ListView.builder(
                itemCount: widget.services.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServiceView(
                            idClient: clientData['id'],
                            service: widget.services[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: ListTile(
                        title: Text(
                          widget.services[index]['intitule'].toString(),
                          style: const TextStyle(
                              fontFamily: "Baloo", fontSize: 20),
                        ),
                        subtitle: Text(
                          widget.services[index]['tarifs'].toString(),
                          style: const TextStyle(
                              fontFamily: "Baloo", fontSize: 18),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
