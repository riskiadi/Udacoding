import 'package:data_mahasiswa/db_helper.dart';
import 'package:data_mahasiswa/models/mahasiswa.dart';
import 'package:data_mahasiswa/utils/color.dart';
import 'package:data_mahasiswa/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreatePage extends StatefulWidget {

  final Map<String, dynamic> data;
  const CreatePage({Key key, this.data}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  var _formKey = GlobalKey<FormState>();
  var _scafoldKey = GlobalKey<ScaffoldState>();

  var inputName = TextEditingController();
  var inputNim = TextEditingController();
  var inputAlamat = TextEditingController();
  var inputTahun = TextEditingController();
  String sex;
  Mahasiswa data;

  @override
  void initState() {
    if(widget.data!=null){
      data = Mahasiswa.fromMap(widget.data);
      inputName.text = data.nama;
      inputNim.text = data.nim;
      inputAlamat.text = data.alamat;
      inputTahun.text = data.tahun.toString();
      sex = data.jnsKelamin;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text('Add Data Mahasiswa'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormWidget(
                        textController: inputName,
                        formLabel: 'Nama',
                        formHint: 'Nama Mahasiswa',
                      ),
                    ),
                    Expanded(
                      child: TextFormWidget(
                        textController: inputNim,
                        formLabel: 'Nim',
                        formHint: 'Nim Mahasiswa',
                      ),
                    ),
                  ],
                ),
                TextFormWidget(
                  textController: inputAlamat,
                  formLabel: 'Alamat',
                  formHint: 'Alamat Mahasiswa',
                ),
                TextFormWidget(
                  textController: inputTahun,
                  formLabel: 'Tahun Masuk',
                  formHint: 'Tahun Masuk Mahasiswa',
                  isNumberFormat: true,
                ),
                SizedBox(height: 5),
                //ComboBox
                Container(
                  color: Colors.black12,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 7, bottom: 7),
                  child: DropdownButton(
                    key: Key('sex'),
                    hint: Text('Jenis Kelamin'),
                    isExpanded: true,
                    underline: Container(),
                    value: sex,
                    items: [
                      DropdownMenuItem(
                        child: Text('Laki Laki'),
                        value: 'Laki - Laki',
                      ),
                      DropdownMenuItem(
                        child: Text('Perempuan'),
                        value: 'Perempuan',
                      ),
                    ],
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        sex = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 35),
                FlatButton(
                  color: Colors.black54,
                  child: Text(data==null ? 'Input Data' : 'Update Data', style: TextStyle(color: Colors.white, fontSize: 17),),
                  onPressed: (){
                    if(_formKey.currentState.validate() && sex!=null){
                      inputData();
                    }else{
                      _scafoldKey.currentState.showSnackBar(SnackBar(content: Text('Please enter all data or valid year.', style: TextStyle(color: Colors.white),)));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  inputData(){
    var database = DatabaseHelper();
    if(data==null){
      database.createMahasiswa(Mahasiswa(inputNim.text, inputName.text, sex, inputAlamat.text, int.parse(inputTahun.text))).then((value){
        Navigator.pop(context, 'refresh');
        toast('Create account success');
      });
    }else{
      Map<String, dynamic> _input = {
        "id": data.id,
        "nama": inputName.text,
        "nim": inputNim.text,
        "alamat": inputAlamat.text,
        "jnsKelamin": sex,
        "tahun": int.parse(inputTahun.text),
      };
      database.updateMahasiswa(Mahasiswa.fromMap(_input)).then((value){
        Navigator.pop(context, 'refresh');
        toast('Update success');
      });
    }
  }

  toast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: CustomColor.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

}