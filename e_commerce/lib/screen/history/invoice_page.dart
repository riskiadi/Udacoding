import 'package:e_commerce/model/invoice_model.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/repository/network_repo.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/utils/session_manager.dart';

class InvoicePage extends StatefulWidget {

  final String invoiceCode;

  const InvoicePage({this.invoiceCode});

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {

  User _userData;
  InvoiceModel _invoiceModel;
  int _detailTotal = 0;


  @override
  void initState() {
    super.initState();
    sessionManager.getUser().then((User user){
      _userData = user;
      getInvoiceData().then((InvoiceModel invoiceModel){
        _detailTotal = 0;
        setState(() {
          _invoiceModel = invoiceModel;
        });
        _invoiceModel.invoice.forEach((Invoice invoice) {
          _detailTotal+= invoice.detailTotal;
        });
        setState(() {});
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 13),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8,)
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Image.asset('images/bakulan.png', width: 50,),
                        SizedBox(height: 4,),
                        Text('Bakulan', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('INVOICE', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                        SizedBox(height: 6,),
                        Text('${widget.invoiceCode}'),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1,),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pembeli:', style: TextStyle(fontWeight: FontWeight.w500,),),
                    SizedBox(height: 4,),
                    Text('${_userData==null? '' : _userData.userNama}', style: TextStyle(height: 1.2),),
                    Text('${_userData==null? '' : _userData.userHp}', style: TextStyle(height: 1.3),),
                  ],
                ),
              ),
              SizedBox(height: 12,),

              _invoiceModel==null ? Center(child: CircularProgressIndicator()) :
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: _invoiceModel.invoice.length,
                itemBuilder: (context, index) {

                  List<TableRow> tableContent = [];

                  if(index==0){
                    tableContent.add(
                        TableRow(children: [
                          TableCell(child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('#'),
                            ),
                          )),
                          TableCell(child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Produk'),
                            ),
                          )),
                          TableCell(child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Qty'),
                            ),
                          )),
                          TableCell(child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Harga'),
                            ),
                          )),
                          TableCell(child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Jumlah'),
                            ),
                          )),
                        ])
                    );
                  }

                  tableContent.add(
                      TableRow(children: [
                        TableCell(child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${index+1}'),
                          ),
                        )),
                        TableCell(child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${_invoiceModel.invoice[index].produkNama}'),
                          ),
                        )),
                        TableCell(child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${_invoiceModel.invoice[index].detailQty}'),
                          ),
                        )),
                        TableCell(child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${_invoiceModel.invoice[index].detailHarga}'),
                          ),
                        )),
                        TableCell(child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${_invoiceModel.invoice[index].detailTotal}'),
                          ),
                        )),
                      ])
                  );

                  return Table(
                    border: TableBorder.all(),
                    columnWidths: {
                      0: FlexColumnWidth(0.3),
                      1: FlexColumnWidth(1.5),
                      2: FlexColumnWidth(0.7),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1),
                    },
                    children: tableContent,
                  );
                },
              ),

              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15,),
                    Text('TOTAL', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                    SizedBox(height: 4,),
                    Text('${moneyFormat(_detailTotal,type: TypeMonFormat.Decimal)}'),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<InvoiceModel> getInvoiceData() async{
    return networkRepo.getInvoice(_userData.userId.toString(), widget.invoiceCode);
  }

}
