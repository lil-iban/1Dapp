import 'package:flutter/material.dart';
import 'package:flutter_web3_app/core/states/states.dart';
import 'package:flutter_web3_app/ui/screens/screens.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractState>(
      create: (_) => ContractState(),
      child: MaterialApp(
        title: "Hello World",
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.cyan[400],
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
