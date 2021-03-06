import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import '../components/pill_button.dart';
import '../services/wallet.service.dart';

class WalletPage extends StatefulWidget {
  @override
  createState() => new WalletPageState();
}

class WalletPageState extends State<WalletPage> {

  TextEditingController _symbol  = new TextEditingController();
  TextEditingController _label   = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  WalletProvider _wp = new WalletProvider();

  scan() async {
    _address.text = await BarcodeScanner.scan();
  }
  saveWallet(BuildContext ctx) async {
    await _wp.addWallet(_symbol.text.toUpperCase().trim(), _label.text, _address.text);
    Navigator.of(ctx).pushReplacementNamed('/portfolio');
  }

  @override
  Widget build(BuildContext ctx) {
    return new Scaffold(
      body: new Form(
        child: new Padding(
          padding: new EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[
              new FormField(
                builder: (state) => new TextField(
                  controller: _symbol,
                  decoration: const InputDecoration(labelText: 'Symbol', hintText: 'e.g. ETH')
                ),
              ),
              new FormField(
                builder: (state) => new TextField(
                  controller: _label,
                  decoration: const InputDecoration(labelText: 'Label', hintText: 'My primary wallet')
                ),
              ),
              new FormField(
                builder: (state) => new TextField(
                  controller: _address,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
              ),
              new IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: scan,
              ),
              new PillButton(
                minWidth: 300.0,
                onPressed: () => saveWallet(ctx),
                child: new Text('Save', style: new TextStyle(fontSize: 18.0),),
                color: const Color(0xffeeeeee),
              )
            ],
          ),
        )
      )
    );
  }
}