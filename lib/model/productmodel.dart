class CardamomData {
  final int sl;
  final String date;
  final String auctioneer;
  final String lots;
  final String totalArrived;
  final String qtySold;
  final String maxPrice;
  final String avgPrice;
  final String type;

  CardamomData({
    required this.sl,
    required this.date,
    required this.auctioneer,
    required this.lots,
    required this.totalArrived,
    required this.qtySold,
    required this.maxPrice,
    required this.avgPrice,
    required this.type,
  });

  factory CardamomData.fromJson(Map<String, dynamic> json) {
    return CardamomData(
      sl: json['sl'],
      date: json['date'],
      auctioneer: json['Auctioneer'],
      lots: json['Lots'],
      totalArrived: json['Total_Arrived'],
      qtySold: json['Qty_Sold'],
      maxPrice: json['MaxPrice'],
      avgPrice: json['Avg_Price'],
      type: json['type'],
    );
  }
}
