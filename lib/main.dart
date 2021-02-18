import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      home: Main(),
    );
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Payment Card Demo'),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.account_box,
                        color: Colors.grey[500],
                        size: 50,
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      labelText: 'Card Name',
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                    ),
                  )),
              Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(19),
                      new FormatNomorKartu()
                    ],
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.credit_card,
                        color: Colors.grey[500],
                        size: 50,
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      labelText: 'Number',
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                    ),
                  )),
              Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(3),
                    ],
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.credit_card_sharp,
                        color: Colors.grey[500],
                        size: 50,
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      labelText: 'CVV',
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                    ),
                  )),
              Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(4),
                      new FormatTanggal()
                    ],
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.grey[500],
                        size: 50,
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'MM/YY',
                      labelText: 'Expiry Date',
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                    ),
                  )),
              Container(
                  padding: EdgeInsets.all(50),
                  child: RaisedButton(
                      padding: EdgeInsets.all(10),
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Pay'),
                      onPressed: () {},
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(7),
                      ))),
            ],
          ),
        ));
  }
}

class FormatNomorKartu extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue valueSebelumnya, TextEditingValue valueBaru) {
    var nomorKartu = valueBaru.text;

    if (valueBaru.selection.baseOffset == 0) {
      return valueBaru;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < nomorKartu.length; i++) {
      buffer.write(nomorKartu[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != nomorKartu.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return valueBaru.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class FormatTanggal extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue valueSebelumnya, TextEditingValue valueBaru) {
    var valueTanggal = valueBaru.text;

    if (valueBaru.selection.baseOffset == 0) {
      return valueBaru;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < valueTanggal.length; i++) {
      buffer.write(valueTanggal[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != valueTanggal.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return valueBaru.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
