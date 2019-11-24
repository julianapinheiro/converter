import 'package:converter/localization/converter_localizations.dart';
import 'package:converter/localization/converter_localizations_delegate.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'country_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Info Helper', // TODO: localizar
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainPage(title: 'Country Info Helper'), // TODO: localizar
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

  Widget _buildCountryPage() {
    if (_selected != null) {
      print("not null");
      return CountryInfo(
        country: _selected,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                        ConverterLocalizations.of(context)
                            .chooseCountry, // TODO: localizar
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CountryPickerDropdown(
                        initialValue: 'br',
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
