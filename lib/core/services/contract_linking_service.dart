import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

class ContractLinkingService {
  Future<String> getAbi(String path) async {
    // Reading the contract abi
    String abiStringFile = await rootBundle.loadString(path);
    var jsonAbi = jsonDecode(abiStringFile);

    return jsonEncode(jsonAbi["abi"]);
  }

  Future<EthereumAddress> getContractAddress(String path, String net) async {
    // Reading the contract abi
    String abiStringFile = await rootBundle.loadString(path);
    var jsonAbi = jsonDecode(abiStringFile);

    return EthereumAddress.fromHex(jsonAbi["networks"][net]["address"]);
  }

  Future<Credentials> getCredentials(String _privateKey) async {
    return EthPrivateKey.fromHex(_privateKey);
  }

  Future<DeployedContract> getDeployedContract(
      String _abiCode, String _name, EthereumAddress _contractAddress) async {
    //  Telling Web3dart where our contract is declared.

    return DeployedContract(
        ContractAbi.fromJson(_abiCode, _name), _contractAddress);
  }
}
