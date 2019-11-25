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
  String _currency;
  String _date;

  Future<String> _getCountryCurrentDate(String countryCode) async {
    NetworkHelper helper =
        NetworkHelper('https://restcountries.eu/rest/v2/alpha/${countryCode}');

    var countryData = await helper.getData();
    NetworkHelper timezoneHelper = NetworkHelper(
        'http://api.timezonedb.com/v2.1/list-time-zone?key=API_KEY&format=json&country=${countryData['alpha2Code']}');

    var availableTimezones = await timezoneHelper.getData();

    var timezone = availableTimezones['zones'][0]['zoneName'];
    NetworkHelper dateHelper = NetworkHelper(
        'http://api.timezonedb.com/v2.1/get-time-zone?key=API_KEY&format=json&by=zone&zone=${timezone}');
    var date = await dateHelper.getData();

    if (date != null) {
      return date['formatted'];
    }
  }

  Future<String> _getCountryCurrency(String countryCode) async {
    NetworkHelper helper =
        NetworkHelper('https://restcountries.eu/rest/v2/alpha/${countryCode}');

    var countryData = await helper.getData();

    var currency = countryData['currencies'][0];
    NetworkHelper currencyHelper = NetworkHelper(
        'https://api.exchangeratesapi.io/latest?symbols=USD&base=${currency['code']}');

    var currencyData = await currencyHelper.getData();

    if (currencyData != null) {
      return currencyData['rates']['USD'].toString();
    }
  }

  Widget _buildCountryPage() {
    if (_selected != null) {
      return CountryInfo(
        country: _selected,
        currency: _currency,
        date: _date,
      );
    } else {
      return Container(
          child: Text(
              'Could not load data for selected country.') // TODO: Localizar,
          );
    }
  }

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text(
                "+${country.phoneCode} ${country.name.split(' ')[0]} (${country.isoCode})"),
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
                      padding: EdgeInsets.all(10.0),
                      child: CountryPickerDropdown(
                        initialValue: 'br',
                        itemBuilder: _buildDropdownItem,
                        onValuePicked: ((country) async {
                          var currency =
                              await _getCountryCurrency(country.iso3Code);
                          var date =
                              await _getCountryCurrentDate(country.iso3Code);

                          setState(() {
                            _selected = country;
                            _currency = currency;
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
