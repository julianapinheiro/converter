import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'country_page.dart';

void main() => runApp(CountryHelper());

class CountryHelper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Country Info Helper', // TODO: localizar
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Countries(title: 'Country Info Helper') // TODO: localizar
        );
  }
}

class CountriesState extends State<Countries> {
  Country _selected;

  Widget _buildCountryPage() {
    if (_selected != null) {
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
                        'Choose country:', // TODO: localizar
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CountryPicker(
                        dense: false,
                        showDialingCode: false,
                        onChanged: (Country country) {
                          setState(() {
                            _selected = country;
                          });
                        },
                        selectedCountry: _selected,
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

class Countries extends StatefulWidget {
  Countries({Key key, this.title}) : super(key: key);

  final String title;

  @override
  CountriesState createState() => CountriesState();
}
