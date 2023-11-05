import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:service_pay_client/backend/laravel.dart';

class ListeDemandes extends StatefulWidget {
  final Map<String, dynamic> client;
  const ListeDemandes({Key? key, required this.client}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListeDemandesState createState() => _ListeDemandesState();
}

class _ListeDemandesState extends State<ListeDemandes> {
  Map<String, dynamic> servicetData = {};

  Future<void> recuperclient() async {
    String id = widget.client['id'].toString(); // Remplacez par votre URL

    final response =
        await ConnexionLaravel().recupeClient('demandesEnvoyer/$id');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // ignore: avoid_print
      print(data);
      if (mounted) {
        setState(() {
          servicetData = data;
          // ignore: avoid_print
          print(servicetData);
          // ignore: avoid_print
          print('ok !');
        });
      }
    } else {
      if (mounted) {
        setState(() {
          servicetData = {'error': 'Erreur: ${response.statusCode}'};
        });
        // ignore: avoid_print
        print("NO !");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataPeriodically();
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
                          child: const Text(
                            "Demande de service envoyer",
                            style: TextStyle(fontFamily: "Baloo", fontSize: 22),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          if (servicetData.isEmpty) ...[
            const Text(
              "Il n'y a aucune demande de services à votre nom !",
              style: TextStyle(fontFamily: "Baloo", fontSize: 20),
            )
          ],
          Expanded(
              child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  child: const ListTile(
                    title: Text(
                      "demande de service valider",
                      style: TextStyle(fontFamily: "Baloo", fontSize: 20),
                    ),
                    subtitle: Text(
                      "message",
                      overflow: TextOverflow.clip,
                      style: TextStyle(fontFamily: "Baloo", fontSize: 18),
                    ),
                  ),
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}
