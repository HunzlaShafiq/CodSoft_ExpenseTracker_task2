import 'package:task1_expense_tracker/bar%20graph/Bar_Data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  const MyBarGraph({super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  @override
  Widget build(BuildContext context) {
    //initialized bar data
    BarData myBarDate =BarData(
        sunAmount: sunAmount,
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thurAmount: thurAmount,
        friAmount: friAmount,
        satAmount: satAmount);
    myBarDate.initializeBarData();

    return BarChart(
      BarChartData(
        gridData:const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData:const FlTitlesData(
          show: true,
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(
              showTitles: true,
            getTitlesWidget: getBottomTiles,
          )),
        ),
        maxY: maxY,
        minY: 0,
        barGroups: myBarDate.barData.map(
              (data) => BarChartGroupData(
                x: data.x,
              barRods: [
                BarChartRodData(
                  toY: data.y,
                  color:const Color(0xff40E0D0).withOpacity(.7),
                  width: 25,
                  borderRadius: BorderRadius.circular(4),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: maxY,
                    color:const Color(0xff40E0D0).withOpacity(.2)
                  )

              )]
            ),

        ).toList(),
      )
    );
  }
}


Widget getBottomTiles (double value, TitleMeta meta)
{
  const style = TextStyle(
    color: Color(0xff40E0D0),
    fontWeight: FontWeight.bold,
    fontSize: 14
  );

  Widget text;

  switch(value.toInt())
  {
    case 0:
      return text=const Text('S',style: style,);
    case 1:
      return text=const Text('M',style: style,);
    case 2:
      return text=const Text('T',style: style,);
    case 3:
      return text=const Text('W',style: style,);
    case 4:
      return text=const Text('T',style: style,);
    case 5:
      return text=const Text('F',style: style,);
    case 6:
      return text=const Text('S',style: style,);
    default:
      return text =const Text('');
  }

}