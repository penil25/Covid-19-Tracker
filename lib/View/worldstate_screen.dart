import 'package:covid_tracker/Models/WorldStatesModel.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/countrieslist_screen.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin{

  late final animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  final colorList = [
        Color(0xff4285F4),
        Color(0xff1aa260),
        Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {

    var statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .05,),
              FutureBuilder(
                  future: statesServices.getWorldstatesdata(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                    if(!snapshot.hasData){
                        return Expanded(
                            flex: 1,
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              controller: animationController,
                              size: 50,
                            ),
                        );
                    }
                    else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(snapshot.data!.cases.toString()),
                              "Recovered": double.parse(snapshot.data!.cases.toString()),
                              "Deaths": double.parse(snapshot.data!.deaths.toString())
                            },
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: true
                            ),
                            animationDuration: Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            chartRadius: MediaQuery.of(context).size.width /3.2,
                            colorList: colorList,
                            legendOptions: LegendOptions(
                              legendShape: BoxShape.rectangle,
                              legendPosition: LegendPosition.left,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * .06),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                  ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                  ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                  ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                  ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                  ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                  ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesListScreen()));
                             }
                            ,child: Container(
                              height: 50,
                              child: Center(
                                child: Text('Track Countries'),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }
              ),


            ],
          ),
        ),
      ),
    );
  }
}


class ReusableRow extends StatelessWidget {

  String title, value;
  ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Text(value),
              ],
            ),
            SizedBox(height: 5,),
            Divider(

            )
          ],
        ),
    );
  }
}

