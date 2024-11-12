import 'package:flutter/material.dart';
import 'package:flutter_web3_app/core/states/states.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Getting the value and object or contract_linking
    final contractLink = Provider.of<ContractState>(context);
    TextEditingController _textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Contract Test!"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        contractLink.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Colors.tealAccent),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 29),
                    child: TextFormField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Your Name",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      child: const Text(
                        'Set your name',
                        style: TextStyle(fontSize: 30),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        contractLink.setName(_textController.text);
                        _textController.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await contractLink.getName(),
      ),
    );
  }
}
