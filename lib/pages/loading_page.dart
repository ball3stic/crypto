import 'package:crypto/data/coin.dart';
import 'package:crypto/functions/changePage.dart';
import 'package:crypto/pages/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Coin List:
List<Coin> coinList = [];

// ignore: must_be_immutable
class LoadingPage extends StatefulWidget {
  LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

String apiURL = "https://api.coincap.io/v2/assets";

// Dio Object:
Dio requests = Dio();

// API Response:
Response? response;

class _LoadingPageState extends State<LoadingPage> {
  // API URL:

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getData(context, HomePage(), doChangePage: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/logo.png'),
            ),
            SizedBox(height: 10),
            SpinKitWave(
              color: Colors.lightGreen,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Coin>> getData(BuildContext context, Widget nextPage,
    {bool doChangePage = false}) async {
  response = await requests.get(apiURL);
  List<dynamic> list = response!.data["data"];
  coinList = list.map<Coin>((e) => Coin.fromMapJson(e)).toList();
  doChangePage == true ? changePage(nextPage, context) : ();
  return coinList;
}
