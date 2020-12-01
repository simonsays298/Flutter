import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(title: 'Currency Convertor'),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String money = '';
  String error = '';
  double currency;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Image.network(
                  'https://www.romania-insider.com/sites/default/files/styles/article_large_image/public/2020-09/currency_exchange_money_businness_ron_eur_by_henning_marquardt_dreamstime.com_.jpg',
                  height: 200.0,
                  width: 500.0,
                ),
                TextField(
                  onChanged: (String value) {
                    money = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorText: error,
                    hintText: 'Enter the amount in EUR',
                  ),
                ),
                RaisedButton(
                  child: const Text('Convert'),
                  onPressed: () {
                    setState(() {
                      if (money.isEmpty) {
                        error = 'Please enter a number';
                        show = false;
                      } else {
                        if (money.isNotEmpty && !money.contains('..')) {
                          currency = 4.83 * double.parse(money);
                          currency = num.parse(currency.toStringAsFixed(2));
                          show = true;
                        } else {
                          error = 'please enter a valid number';
                          show = false;
                        }
                      }
                    });
                  },
                ),
                Visibility(
                  child: Text(
                    currency.toString() + ' RON',
                    style: const TextStyle(fontSize: 30),
                  ),
                  visible: show,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
