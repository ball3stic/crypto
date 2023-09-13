class Coin {
  String id;
  String name;
  String symbol;
  double changePercent24Hr;
  double price;
  double marketCap;
  int rank;

  Coin(
    this.id,
    this.name,
    this.symbol,
    this.changePercent24Hr,
    this.price,
    this.marketCap,
    this.rank,
  );

  factory Coin.fromMapJson(Map<String, dynamic> jsonMap) {
    return Coin(
      jsonMap["id"],
      jsonMap["name"],
      jsonMap["symbol"],
      double.parse(jsonMap["changePercent24Hr"]),
      double.parse(jsonMap["priceUsd"]),
      double.parse(jsonMap["marketCapUsd"]),
      int.parse(jsonMap["rank"]),
    );
  }
}
