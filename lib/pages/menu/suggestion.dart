import 'package:flutter/material.dart';
import 'package:service_pay_client/widget/bouton.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SuggestionsState createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  Map<String, dynamic> clientData = {};
  TextEditingController nom = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                            "Suggesttion",
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
          Expanded(
            child: Container(
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
                      maxLines: null,
                      decoration: InputDecoration(
                          hintText: "Entrer votre méssage...",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Baloo",
                              fontSize: 18),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MonBouton(
                      action: () {},
                      btntexte: "envoyer",
                      btncolor: const Color.fromARGB(255, 42, 12, 79),
                      textecolor: Colors.white)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
