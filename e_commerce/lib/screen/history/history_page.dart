import 'package:e_commerce/model/history_model.dart';
import 'package:e_commerce/repository/network_repo.dart';
import 'package:e_commerce/screen/history/invoice_page.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<DataHistory> listHistory = [];

  void getHistory() async {
    var result = await networkRepo.getHistory();
    if (this.mounted) {
      setState(() {
        listHistory = result;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text("History", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: listHistory == null
          ? Center(child: Text("Data Kosong"))
          : listHistory.length == 0
              ? Center(child: CircularProgressIndicator())
              : Container(
                  margin: EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: listHistory?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      DataHistory data = listHistory[index];
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4)),
                                  color: baseColor.withOpacity(0.25),
                                ),
                                child: Text("Pesanan Selesai",
                                    style: TextStyle(fontSize: 12))),
                            Container(
                              padding: EdgeInsets.only(top: 8),
                              margin: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(dateFormat(DateTime.now()),
                                          style: TextStyle(fontSize: 12)),
                                      Text("${data?.detailOrder}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700))
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => InvoicePage(invoiceCode: data?.detailOrder,),
                                        ),
                                      );
                                    },
                                    child: Text("Invoice"),
                                  ),
                                ],
                              ),
                            ),
                            Divider(thickness: 1),
                            Container(
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                              child: ListTile(
                                leading: Image.network(dummySeller,
                                    width: 60, height: 60, fit: BoxFit.fill),
                                title: Text("${data?.produkNama}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                                subtitle: Text(
                                    "${data?.detailQty} Barang(0.5 kg)",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                            Divider(thickness: 1),
                            Container(
                              margin: EdgeInsets.only(left: 60, bottom: 8),
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Total Pembayaran",
                                      style: TextStyle(fontSize: 12)),
                                  Text(
                                      moneyFormat(data?.detailTotal ?? 0,
                                          type: TypeMonFormat.Decimal),
                                      style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16))
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }

}
