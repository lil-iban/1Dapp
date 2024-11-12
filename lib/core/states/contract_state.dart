import 'package:flutter/material.dart';
import 'package:flutter_web3_app/core/services/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractState extends ChangeNotifier {
  final ContractLinkingService contractLinkingService =
      ContractLinkingService();
  final String _rpcUrl = "http://10.0.2.2:8545";
  final String _wsUrl = "ws://10.0.2.2:8545/";
  final String _privateKey =
      '0xc91114cb6131eb7a9d474e12d57208cda1d73464eb3426b5cc78059a340cb781';

  String name = '';

  late Web3Client _client;
  late String _abiCode;
  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late DeployedContract _contract;

  ContractState() {
    initialSetup();
  }

  initialSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    _abiCode =
        await contractLinkingService.getAbi("assets/artifacts/MyName.json");
    _contractAddress = await contractLinkingService.getContractAddress(
        "assets/artifacts/MyName.json", "1638969405913");
    _contract = await contractLinkingService.getDeployedContract(
        _abiCode, "MyName", _contractAddress);
    _credentials = await contractLinkingService.getCredentials(_privateKey);
  }

  getName() async {
    // Getting the current name declared in the smart contract.

    var currentName = await _client.call(
        contract: _contract,
        function: _contract.function("getName"),
        params: []);
    name = currentName[0];
    notifyListeners();
  }

  setName(String name) async {
    // Setting the name to nameToSet(name defined by user)
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _contract.function("setName"),
            parameters: [name]));
    getName();
  }
}
