import 'package:e_commerce/model/keranjang_model.dart';
import 'package:e_commerce/model/shipping_model.dart';
import 'package:e_commerce/repository/network_repo.dart';
import 'package:e_commerce/screen/cart/shipping/list_address_page.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<DataKeranjang> listKeranjang = [];
  Shipping addrShipping;
  List<int> listOngkir = [];
  String addressOrder = "-";
  int priceDiliver = 11000;
  getKeranjang() async {
    var result = await networkRepo.getKeranjang();
    List<Shipping> resShipping = await networkRepo.getShipping();
    setState(() {
      if (result != null) {
        listKeranjang = result;
        listKeranjang.forEach((element) => listOngkir.add(11000));
      }
      if (resShipping != null) {
        resShipping.sort((a, b) => a.title.compareTo(b.title));
        addrShipping = resShipping[0];
        addressOrder = "${addrShipping?.address ?? ""}, ${addrShipping?.city ?? ""}, ${addrShipping?.province ?? ""} ${addrShipping?.zipCode ?? ""}";
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKeranjang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text("Checkout", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Divider(thickness: 15, color: Colors.black.withOpacity(0.1)),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Alamat Pengiriman",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                          Container(
                            child: FlatButton(
                              child: Text("Pilih Alamat Lain",
                                  style: TextStyle(
                                      color: baseColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12)),
                              onPressed: () async {
                                var res = await goTo(context,
                                    ListAddressPage(defShipping: addrShipping));
                                setState(() {
                                  if (res != null) {
                                    addrShipping = res;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Divider(thickness: 1),
                      Text("${addrShipping?.title ?? ""}",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w700)),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(addressOrder,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  )),
              Divider(thickness: 15, color: Colors.black.withOpacity(0.1)),
              Container(
                  margin: EdgeInsets.all(16),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Metode Pembayaran",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16)),
                            SizedBox(height: 10),
                            Text("Transfer Bank\n",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Image.network(
                              bcaLogo,
                              width: 50,
                              height: 50,
                            ),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.black87),
                          ],
                        )
                      ],
                    ),
                  )),
              Divider(thickness: 15, color: Colors.black.withOpacity(0.1)),
              listKeranjang.length == 0
                  ? Center()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listKeranjang?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        DataKeranjang data = listKeranjang[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [BoxShadow(blurRadius: 0.5)],
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            imageUrl + data?.produkGambar),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                title: Text(data?.produkNama,
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                                subtitle: Container(
                                  margin: EdgeInsets.only(top: 4),
                                  child: RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                        children: [
                                          TextSpan(
                                              text:
                                                  "${data?.detailQty} Item (0.5kg)\n",
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                          TextSpan(
                                              text: moneyFormat(
                                                  data?.produkHarga ?? 0,
                                                  type: TypeMonFormat.Decimal),
                                              style: TextStyle(
                                                  color: Colors.deepOrange,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14)),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              padding: EdgeInsets.only(bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Divider(thickness: 1),
                                  Text("Kurir",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                          "Sicepat REG - Rp. 11.000 (2 Hari Kerja)",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400)),
                                      Row(
                                        children: <Widget>[
                                          Image.network(sicepat),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              padding: EdgeInsets.only(bottom: 16),
                              child: Column(
                                children: <Widget>[
                                  Divider(thickness: 1),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Subtotal",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                      Text(
                                          moneyFormat(
                                              (data?.detailTotal ?? 0) + priceDiliver,
                                              type: TypeMonFormat.Decimal),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                                thickness: 15,
                                color: Colors.black.withOpacity(0.1)),
                          ],
                        );
                      },
                    ),
              Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Ringkasan Belanja",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Harga (${listKeranjang.length} Item)",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12)),
                        Text(moneyFormat(0, type: TypeMonFormat.Decimal),
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Ongkos Kirim",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12)),
                        Text(moneyFormat(0, type: TypeMonFormat.Decimal),
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12)),
                      ],
                    ),
                    SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 9,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(text: "Dengan membayar, saya menyetujui "),
                          TextSpan(
                              text: "syarat dan ketentuan asuransi",
                              style: TextStyle(color: baseColor)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 5)]),
        child: BottomAppBar(
          elevation: 5,
          child: Row(
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Total Tagihan",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 12)),
                      Text("Rp 0",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  height: 40,
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    color: baseColor,
                    child: Text(
                      "Checkout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async{
                      progressDialog(context);
                       listKeranjang.forEach((e) async {
                              await networkRepo.updateQty(
                                  e.detailQty, (e.detailTotal + priceDiliver), e.detailId);
                                  });
                      await networkRepo.checkoutKeranjang(addressOrder, 0).then((value){
                        Navigator.pop(context);
                        Navigator.pop(context, 2);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
