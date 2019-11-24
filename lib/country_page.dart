import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class CountryInfoState extends State<CountryInfo> {
  DateTime now = DateTime.now();

  String _formatDate() {
    return DateFormat('kk:mm:ss \n EEE d MMM').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Current time:',         // TODO: localizar
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            '${_formatDate()}',         // TODO: localizar
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],)
                  )
              ],)
          ),
          Card(
            child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Currency converter: ',         // TODO: localizar
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
              ],)
          ),
      ],)
    );
  }
}

class CountryInfo extends StatefulWidget {
  @override
  CountryInfoState createState() => CountryInfoState();

  final Country country;

  CountryInfo({Key key, @required this.country}) : super(key: key);
}
