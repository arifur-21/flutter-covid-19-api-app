
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class CountryDetails extends StatefulWidget {

  String name, image;
  int totalCases, totalDeaths, totalRecovered, active,critical,todayRecovered,test;

 CountryDetails({
   required this.name,
   required this.image,
   required this.totalCases,
   required this.totalDeaths,
   required this.totalRecovered,
   required this.active,
   required this.critical,
   required this.todayRecovered,
   required this.test
 });

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(

                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * .06,),
                          ResualbeRowList(title: 'Cases', value: widget.totalCases.toString()),
                          ResualbeRowList(title: 'Deaths', value: widget.totalDeaths.toString()),
                          ResualbeRowList(title: 'Recovered', value: widget.totalRecovered.toString()),
                          ResualbeRowList(title: 'Active', value: widget.active.toString()),
                          ResualbeRowList(title: 'Critical', value: widget.critical.toString()),
                          ResualbeRowList(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                          ResualbeRowList(title: 'Test', value: widget.test.toString()),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
