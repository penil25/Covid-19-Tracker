import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {

  var searchController = TextEditingController();

  @override
  var statesservices = StatesServices();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {

                  });
                  },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Search By Country Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: statesservices.getCountriesList(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                      if(!snapshot.hasData){
                        return ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index){
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade300,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Container(height: 50,width: 50,color: Colors.white,),
                                      title: Container(height: 10,width: 89,color: Colors.white,),
                                      subtitle: Container(height: 10,width: 89,color: Colors.white,),
                                    )
                                  ],
                                ),
                              );
                            }
                        );
                      }
                      else{
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){
                              String name = snapshot.data![index]['country'];

                              if(searchController.text.isEmpty){
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                          name: snapshot.data![index]['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                          active: snapshot.data![index]['active'],
                                          critical: snapshot.data![index]['critical'],
                                          todayRecovered: snapshot.data![index]['todayRecovered'],
                                          test: snapshot.data![index]['test'],
                                        )));
                                      },
                                      child: ListTile(
                                        title: Text(snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]['cases'].toString()),
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image:  NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                      ),
                                    ),
                                  ],
                                );
                              }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                          name: snapshot.data![index]['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                          active: snapshot.data![index]['active'],
                                          critical: snapshot.data![index]['critical'],
                                          todayRecovered: snapshot.data![index]['todayRecovered'],
                                          test: snapshot.data![index]['test'],
                                        )));
                                      },
                                      child: ListTile(
                                        title: Text(snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]['cases'].toString()),
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image:  NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              else{
                                return Container();
                              }
                            }
                        );
                      }
                    }
                )
            )
          ],
        ),
      ),
    );
  }
}

