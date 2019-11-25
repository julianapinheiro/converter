import 'package:converter/localization/converter_localizations.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountryInfoState extends State<CountryInfo> {
  String _formatDate() {
    Locale myLocale = Localizations.localeOf(context);
    var currentDateAndTime = DateTime.parse(widget.date);
    return DateFormat.yMMMd(myLocale.languageCode).format(currentDateAndTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Card(
            child: Column(
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
                        ConverterLocalizations.of(context).currentTime,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '${_formatDate()}', // TODO: localizar
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ))
          ],
        )),
        Card(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Today, 1 ${widget.country.iso3Code} is equivalent to ${widget.currency} dolars.", // TODO: Localizar
                style: TextStyle(fontSize: 18.0),
              ),
            )
          ],
        )),
      ],
    ));
  }
}

class CountryInfo extends StatefulWidget {
  @override
  CountryInfoState createState() => CountryInfoState();

  final Country country;
  final String currency;
  final String date;

  CountryInfo(
      {Key key,
      @required this.country,
      @required this.currency,
      @required this.date})
      : super(key: key);
}
