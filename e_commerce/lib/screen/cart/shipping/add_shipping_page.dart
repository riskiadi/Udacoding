import 'package:e_commerce/model/city_model.dart';
import 'package:e_commerce/model/province_model.dart';
import 'package:e_commerce/model/shipping_model.dart';
import 'package:e_commerce/repository/network_repo.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:flutter/material.dart';

class AddShippingPage extends StatefulWidget {
  Shipping dataShipping;
  String status;
  AddShippingPage({this.dataShipping, this.status});
  @override
  _AddShippingPageState createState() => _AddShippingPageState();
}

class _AddShippingPageState extends State<AddShippingPage> {
  List<ProvinceModel> listProvince = [];
  List<CityModel> listCity = [];
  ProvinceModel valProv;
  CityModel valCity;

  void getProvince() async {
    var resultProv = await networkRepo.getProvince();
    setState(() {
      if (resultProv != null) {
        listProvince = resultProv;
      }
    });
  }

  void getCity(id) async {
    var resultCity = await networkRepo.getCity(id);

    setState(() {
      if (resultCity != null) {
        listCity = resultCity;
      }
    });
  }

  void getExisting() async {
    List<ProvinceModel> resultProv = await networkRepo.getProvince();
    if (this.mounted) {
      setState(() {
        listProvince = resultProv;
        valProv = resultProv
                .where((e) => e.province == widget.dataShipping.province)
                ?.toList()[0] ??
            null;
      });

      List<CityModel> resultCity = await networkRepo.getCity(valProv.id);
      setState(() {
        listCity = resultCity;
        valCity = resultCity
                .where((e) => e.city == widget.dataShipping.city)
                ?.toList()[0] ??
            null;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProvince();
    if (widget.status == null) {
      setState(() {
        widget.dataShipping = Shipping();
      });
    } else {
      getExisting();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(widget.status != null ? "Update Alamat" : "Tambah Alamat",
            style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Title Deskripsi",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontSize: 12)),
              TextFormField(
                decoration: InputDecoration(hintText: "Description"),
                initialValue: widget.dataShipping?.title ?? "",
                onChanged: (value) {
                  setState(() => widget.dataShipping?.title = value);
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Text("Alamat",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Address"),
                initialValue: widget.dataShipping?.address ?? "",
                onChanged: (value) {
                  setState(() => widget.dataShipping?.address = value);
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Text("Provinsi",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
              ),
              DropdownButton(
                  isExpanded: true,
                  hint: Text("Select Province"),
                  value: valProv,
                  items: listProvince.map((item) {
                    return DropdownMenuItem(
                      child: Text("${item.province}"),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (ProvinceModel value) {
                    setState(() {
                      valProv = value;
                      widget.dataShipping?.province = value.province;
                      widget.dataShipping?.city = null;
                      valCity = null;
                      listCity = [];
                      getCity(value.id);
                    });
                  }),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Text("Kota",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
              ),
              DropdownButton(
                  isExpanded: true,
                  hint: Text("Select City"),
                  value: valCity,
                  items: listCity.map((item) {
                    return DropdownMenuItem(
                      child: Text("${item.city}"),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (CityModel value) {
                    setState(() {
                      valCity = value;
                      widget.dataShipping?.city = value.city;
                    });
                  }),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Text("Kode POS",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Zip Code"),
                initialValue: widget.dataShipping?.zipCode ?? "",
                onChanged: (value) {
                  setState(() => widget.dataShipping?.zipCode = value);
                },
              ),
              Container(
                height: 45,
                margin: EdgeInsets.only(top: 16),
                width: double.infinity,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: baseColor,
                  child: Text(widget.status != null ? "Update" : "Simpan"),
                  onPressed: () {
                    progressDialog(context);
                    networkRepo
                        .addShipping(widget.dataShipping, widget.status)
                        .then((value) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
