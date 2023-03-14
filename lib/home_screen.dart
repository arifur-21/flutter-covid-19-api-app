
import 'package:covid_19_api_app/country_list_screen.dart';
import 'package:covid_19_api_app/services/state_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pie_chart/pie_chart.dart';

import 'model/WorldStatesModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


   final colorList = <Color>[
    const  Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {

    StateServices stateServices = StateServices();

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Covid-19"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              FutureBuilder(
                future: stateServices.featchWorldStatesRecords(),
                builder: (BuildContext context, AsyncSnapshot<WorldStatesModel> snapshot) {

                  if(!snapshot.hasData){
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.black,
                        size: 50,
                      ),
                    );
                  }else{
                    return Column(
                      children: [
                        PieChart(
                            dataMap: {
                              'Total': double.parse(snapshot.data!.cases.toString()),
                              'Recovered': double.parse(snapshot.data!.recovered.toString()),
                              'Deaths': double.parse(snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius: MediaQuery.of(context).size.width/2.0,
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            animationDuration: Duration(microseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList

                        ),

                        SizedBox(height: 20,),

                        Card(
                            elevation: 6,
                            child: Column(
                              children: [
                                ResualbeRowList(title: "Total", value: snapshot.data!.cases.toString()),
                                ResualbeRowList(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                ResualbeRowList(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                ResualbeRowList(title: "Active", value: snapshot.data!.active.toString()),
                                ResualbeRowList(title: "Critical", value: snapshot.data!.critical.toString()),
                                ResualbeRowList(title: "Today cases", value: snapshot.data!.todayCases.toString()),
                                ResualbeRowList(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                                ResualbeRowList(title: "Today Recoverd", value: snapshot.data!.todayRecovered.toString()),
                              ],
                            )
                        ),
                      ],
                    );
                  }
                },

              ),






              SizedBox(height: 20,),

              GestureDetector(
                onTap:(){
                  Get.to(CountryListScreen());
                },
                child: Container(
                  height: 50,
                  decoration:BoxDecoration(
                    color: Color(0xff1aa260),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Countries", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResualbeRowList extends StatelessWidget {
  String title, value;
 ResualbeRowList({Key? key,required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              Text(value, style: TextStyle(fontSize: 16,),),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
