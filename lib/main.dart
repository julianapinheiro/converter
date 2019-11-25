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

  Future<String> _getCountryCurrentDate(String countryCode) async {
    NetworkHelper helper =
        NetworkHelper('https://restcountries.eu/rest/v2/alpha/${countryCode}');

    var countryData = await helper.getData();
    var timezone = countryData['timezones'][0];

    NetworkHelper timeHelper = NetworkHelper();
  }

  Future<String> _getCountryCurrency(String countryCode) async {
    NetworkHelper helper =
        NetworkHelper('https://restcountries.eu/rest/v2/alpha/${countryCode}');

    var countryData = await helper.getData();

    var currency = countryData['currencies'][0];
    NetworkHelper currencyHelper = NetworkHelper(
        'https://api.exchangeratesapi.io/latest?symbols=USD&base=${currency['code']}');

    var currencyData = await currencyHelper.getData();
    return currencyData['rates']['USD'].toString();
  }

  Widget _buildCountryPage() {
    if (_selected != null) {
      _getCountryCurrency(_selected.iso3Code).then((currency) => CountryInfo(
            country: _selected,
            currency: currency,
          ));

      // return CountryInfo(
      //   country: _selected,
      //   currency: currency,
      // );
    } else {
      return Container();
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
                        onValuePicked: ((country) {
                          setState(() {
                            _selected = country;
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
