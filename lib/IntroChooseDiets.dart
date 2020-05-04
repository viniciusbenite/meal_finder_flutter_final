import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroChooseDiets extends StatefulWidget {

  @override
  _IntroChooseDietsState createState() => _IntroChooseDietsState();

}

class _IntroChooseDietsState extends State<IntroChooseDiets> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose your diets"),
      ),
      body: GridView.count(

        crossAxisCount: 2,
        children: <Widget>[
       Text(
      'Vegan',
        style: Theme.of(context).textTheme.headline,
      ),
         Text(
        'Vegetarian',
        style: Theme.of(context).textTheme.headline,
    ),
    Text(
    'Paleo',
    style: Theme.of(context).textTheme.headline,
    ),
    Text('Macrobiotic',
    style: Theme.of(context).textTheme.headline,
    )]
    ));
  }

}