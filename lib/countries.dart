import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class MyCountries extends StatefulWidget {
  @override
  _MyCountriesState createState() => _MyCountriesState();
}

class _MyCountriesState extends State<MyCountries> {
  Map countries;
  fetchcountries() async {
    http.Response response = await http.get(
        Uri.parse('https://countriesnow.space/api/v0.1/countries/flag/images'));
    setState(() {
      countries = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchcountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return fetchcountries() == null
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: countries['data'].length,
                  itemBuilder: (BuildContext context, index) => Card(
                        elevation: 8,
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network(
                                countries['data'][index]['flag'],
                                height: 80,
                                width: 80,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(countries['data'][index]['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ))),
                            ],
                          ),
                        ),
                      )),
            ),
          );
  }
}
