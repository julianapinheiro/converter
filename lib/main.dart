import 'package:converter/localization/converter_localizations.dart';
import 'package:converter/localization/converter_localizations_delegate.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'country_page.dart';
import 'network_helper.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainPage(),
      localizationsDelegates: [
        ConverterLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale("en"), Locale("pt"), Locale("es")],
      onGenerateTitle: (BuildContext context) =>
          ConverterLocalizations.of(context).title,
    );
  }
}

class MainPageState extends State<MainPage> {
  Country _selected;
  String _currencyCode;
  String _exchangeRate;
  String _languageCode;
  String _date;

  Future<String> _getCountryCurrentDate(String countryCode) async {
    NetworkHelper helper =
        NetworkHelper('https://restcountries.eu/rest/v2/alpha/$countryCode');

    var countryData = await helper.getData();
    NetworkHelper timezoneHelper = NetworkHelper(
        'http://api.timezonedb.com/v2.1/list-time-zone?key=UIUD51Z4MSII&format=json&country=${countryData['alpha2Code']}');

    var availableTimezones = await timezoneHelper.getData();

    var timezone = availableTimezones['zones'][0]['zoneName'];
    NetworkHelper dateHelper = NetworkHelper(
        'http://api.timezonedb.com/v2.1/get-time-zone?key=UIUD51Z4MSII&format=json&by=zone&zone=${timezone}');
    var date = await dateHelper.getData();

    if (date != null) {
      return date['formatted'];
    }
    return '';
  }

  // Get iso639_1 language code (first language), exchange rate and ISO 4217 currency code
  Future<Map> _getCountryData(String countryCode) async {
    var countryDataMap = new Map();
    countryDataMap['languageCode'] = null;
    countryDataMap['currencyCode'] = null;
    countryDataMap['exchangeRate'] = null;

    NetworkHelper helper =
        NetworkHelper('https://restcountries.eu/rest/v2/alpha/$countryCode');

    var countryData = await helper.getData();

    if (countryData == null) return countryDataMap;

    final baseCurrencyCode = countryData['currencies'][0]['code'];

    NetworkHelper currencyHelper = NetworkHelper(
        'https://api.exchangeratesapi.io/latest?symbols=BRL&base=$baseCurrencyCode');

    var currencyData = await currencyHelper.getData();

    if (currencyData != null) {
      countryDataMap['languageCode'] = countryData['languages'][0]['iso639_1'];
      countryDataMap['currencyCode'] = baseCurrencyCode;
      countryDataMap['exchangeRate'] = currencyData['rates']['BRL'].toString();
    }
    return countryDataMap;
  }

  Widget _buildCountryPage() {
    if (_selected != null) {
      return CountryInfo(
        country: _selected,
        currencyCode: _currencyCode,
        exchangeRate: _exchangeRate,
        languageCode: _languageCode,
        date: _date,
      );
    } else {
      return Container(
          child: Text(ConverterLocalizations.of(context).failedLoadData));
    }
  }

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("${country.name.split(' ')[0]}"),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ConverterLocalizations.of(context).title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        ConverterLocalizations.of(context).chooseCountry,
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 70.0, vertical: 10.0),
                      child: CountryPickerDropdown(
                        initialValue: 'br',
                        itemBuilder: _buildDropdownItem,
                        onValuePicked: ((country) async {
                          final date =
                              await _getCountryCurrentDate(country.iso3Code);
                          final countryData =
                              await _getCountryData(country.iso3Code);

                          setState(() {
                            _selected = country;
                            _currencyCode = countryData['currencyCode'];
                            _exchangeRate = countryData['exchangeRate'];
                            _languageCode = countryData['languageCode'];
                            _date = date;
                          });
                        }),
                      ),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: _buildCountryPage(),
            ),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MainPageState createState() => MainPageState();
}
