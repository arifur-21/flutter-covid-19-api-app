
import 'package:covid_19_api_app/services/state_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

import 'country_details.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {

  TextEditingController _searchController = TextEditingController();
  StateServices stateServices = StateServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Country List"),
        centerTitle: true,
      ),

      body: Column(
        children: [

          ///search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: _searchController,
              onChanged: (value){
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: "Search with country name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),

                )
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: stateServices.featchCountryListApi(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                ///// if data not found then show shimmer effect
                if(!snapshot.hasData){
                  return ListView.builder(
                      itemCount: 9,
                      itemBuilder: (context, index){
                        return Shimmer.fromColors(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(height: 10, width: 89, color: Colors.white,),
                                  subtitle: Container(height: 10, width: 89, color: Colors.white,),
                                  leading: Container(height: 10, width: 89, color: Colors.white,),
                                )
                              ],
                            ),
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100);
                      }
                  );
                }
                //// if data found then show list view data
                else{
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){

                        String searchCountryName = snapshot.data![index]['country'];

                        ////check search bar is empty
                      if(_searchController.text.isEmpty){
                        return Column(
                          children: [
                            InkWell(
                              onTap: (){
                                Get.to(CountryDetails(
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  name: snapshot.data![index]['country'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalRecovered: snapshot.data![index]['recovered'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  active: snapshot.data![index]['active'],
                                  test: snapshot.data![index]['tests'],
                                  todayRecovered: snapshot.data![index]['todayRecovered'],
                                  critical: snapshot.data![index]['critical'],
                                ));
                              },

                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  width: 50,
                                  height: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                      ////if search bar is not empty
                      else if(searchCountryName.toLowerCase().contains(_searchController.text.toLowerCase())){
                        return Column(
                          children: [
                            InkWell(
                              onTap:(){
                                Get.to(CountryDetails(
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  name: snapshot.data![index]['country'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalRecovered: snapshot.data![index]['recovered'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  active: snapshot.data![index]['active'],
                                  test: snapshot.data![index]['tests'],
                                  todayRecovered: snapshot.data![index]['todayRecovered'],
                                  critical: snapshot.data![index]['critical'],
                                ));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  width: 50,
                                  height: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                ),
                              ),
                            )
                          ],
                        );
                      }else{
                        return Container();
                      }
                      }
                  );
                }

              },

            ),
          )
        ],
      ),

    );
  }
}
