/*
if we want apply validation make fields inside form
and convert fields to textFormfields.
margin not work with form widget.
3-define globalkey<FormState>

 */

import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  var currencies = ["rupees", "dollar", "pounds"];
  var currentCurrency = "rupees";
  TextEditingController principalController= TextEditingController();
  TextEditingController roiController= TextEditingController();
  TextEditingController termController= TextEditingController();
  String myResult="";
  var _formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var textStyle=Theme.of(context).textTheme.title;
    return Scaffold(
      //resizeToAvoidBottomPadding: false,  // not work with listviews
      appBar: AppBar(
        title: Text("Simple Interest"),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Center(
                child: Image.asset(
                  "images/flight.png",
                  width: 150,
                  height: 200,
                )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: principalController,
                validator: (String value) => value.isEmpty ? "Please enter Principal Amount" : null,
                decoration: InputDecoration(
                    hintText: "enter Principal e.g 12000",
                    labelText: "Principal",
                    hintStyle: textStyle,
                    errorStyle: TextStyle(
                      color: Colors.yellow
                    ),
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: roiController,
                validator: (String value) => value.isEmpty ? "Please enter Rate of Interest" : null,
                decoration: InputDecoration(
                    hintText: "In Percent",
                    labelText: "Rate of Interest",
                    hintStyle: textStyle,
                    errorStyle: TextStyle(
                        color: Colors.yellow
                    ),
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: termController,
                      validator: (String value) => value.isEmpty ? "Please enter Term" : null,
                      decoration: InputDecoration(
                          hintText: "Time in Years",
                          labelText: "Term",
                          hintStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.yellow,
                            fontSize: 15.0
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                      child: DropdownButton(
                        items: currencies.map((String dropDownValues) {
                          return DropdownMenuItem(
                            value: dropDownValues,
                            child: Text(dropDownValues,style: textStyle,),
                          );
                        }).toList(),
                        onChanged: (String newValues) {
                          setState(() {
                            currentCurrency = newValues;
                          });
                        },
                        value: currentCurrency,
                      )),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                      child: RaisedButton(
                        child: Text("Calculate",style: textStyle,),
                        onPressed: (){
                          setState(() {
                            if(_formkey.currentState.validate()) {
                              myResult = calculateROI();
                            }
                          });
                        },
                      )
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 15.0, top: 15.0),
                      child: RaisedButton(
                        child: Text("Reset",style: textStyle),
                        color: Colors.black,
                        onPressed: (){
                          setState(() {
                            principalController.text="";
                            roiController.text="";
                            termController.text="";
                            currentCurrency=currencies[0];
                            myResult="";
                          });
                        },
                      )
                  ),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                child: Text(myResult,style: textStyle)
            )
          ],
        ),
      ),
    );
  }
     String calculateROI(){
          double principal=double.parse(principalController.text);
          double roi=double.parse(roiController.text);
          double term=double.parse(termController.text);
          double pay=principal+(principal*roi*term)/100;
          return "After $term years, your investment will be worth $pay $currentCurrency.";
     }
}
