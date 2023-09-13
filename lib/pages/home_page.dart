import 'package:crypto/data/coin.dart';
import 'package:crypto/functions/getIconStatus.dart';
import 'package:crypto/functions/getPercentWithColor.dart';
import 'package:crypto/pages/loading_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: SafeArea(
        child: getAppBody(context),
      ),
    );
  }

  Widget getAppBody(BuildContext context) {
    setData();
    return Column(
      children: [
        SizedBox(height: 10),
        searchBar(),
        Expanded(
          child: listCoins(context),
        ),
        SizedBox(height: 4),
      ],
    );
  }

  void setData() {
    setState(() {
      coinList = coinList;
    });
  }

  Widget listCoins(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getData(context, HomePage(), doChangePage: false);
        setData();
      },
      child: ListView.builder(
        itemCount: coinList.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blueGrey[50],
            child: ListTile(
              title: Text(coinList[index].name),
              subtitle: Text(coinList[index].symbol),
              leading: SizedBox(
                width: 30,
                child: Center(
                  child: Text(
                    coinList[index].rank.toString(),
                  ),
                ),
              ),
              trailing: SizedBox(
                width: 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(coinList[index].price.toStringAsFixed(2)),
                        getPercentWithColor(coinList[index].changePercent24Hr),
                      ],
                    ),
                    SizedBox(width: 10),
                    getStatusIcon(coinList[index].changePercent24Hr),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "کریپتو بازار",
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'Schyler',
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      elevation: 1,
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          onChanged: (value) async {
            if (value.isEmpty) {
              coinList =
                  await getData(context, HomePage(), doChangePage: false);
            }
            setState(() {
              coinList = searchInList(coinList, value.toString());
            });
          },
          controller: controller,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
            fillColor: Colors.blueGrey[100],
            filled: true,
            hintText: "لطفا نام ارز مورد نظر خود را جستجو کنید",
            hintStyle:
                TextStyle(fontFamily: 'Schyler', color: Colors.grey[800]),
          ),
        ),
      ),
    );
  }

  List<Coin> searchInList(List<Coin> array, String searchKey) {
    List<Coin> list = [];
    array
        .where((element) =>
            element.name.toLowerCase().contains(searchKey.toLowerCase()))
        .toList()
        .forEach((element) {
      list.add(element);
    });
    return list;
  }
}
