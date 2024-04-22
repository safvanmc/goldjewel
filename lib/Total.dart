import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Total extends StatefulWidget {
  final weight;
  final charge;
  final Chargegrm;
  final wastage;
  final selectedcity;
  final carat;
  final gold;
  final goldPrice;
  const Total(
      {super.key,
      this.weight,
      this.charge,
      this.wastage,
      String? this.selectedcity,
      this.carat,
      this.gold,
      this.goldPrice,
      String? this.Chargegrm});

  @override
  State<Total> createState() => _TotalState();
}

class _TotalState extends State<Total> {
  num ounsetogram = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  ounceToGrams(goldPrice) {
    return goldPrice / 31.1035;
  }

  Totalgram(weight, num ounsetogram, goldPrice) {
    num sum;

    sum = widget.gold == 'Grams'
        ? num.parse(weight) * ounsetogram
        : num.parse(weight) * goldPrice;
    return sum;
  }

  TotalMaking(weight, charge) {
    return num.parse(weight) * num.parse(charge);
  }

  wastage(wastage, num totalgramAmount) {
    return (num.parse(wastage) * (totalgramAmount) / 100);
  }

  amountWithoutGst(
      num totalgramAmount, num totalMakingCharge, num amountwastage) {
    return totalgramAmount + totalMakingCharge + amountwastage;
  }

  Gst(num totalwithouGst) {
    var Gstamount = totalwithouGst * 3 / 100;
    print(Gstamount);
    return Gstamount + totalwithouGst;
  }

  @override
  Widget build(BuildContext context) {
    ounsetogram = ounceToGrams(widget.goldPrice);
    num TotalgramAmount =
        Totalgram(widget.weight, ounsetogram, widget.goldPrice);
    num TotalMakingCharge = TotalMaking(widget.weight, widget.charge);
    num amountwastage = wastage(widget.wastage, TotalgramAmount);
    num TotalwithouGst =
        amountWithoutGst(TotalgramAmount, TotalMakingCharge, amountwastage);
    num totalwithGst = Gst(TotalwithouGst);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.sizeOf(context).height / 1.5,
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(30),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade400),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 3,
                      color: Colors.grey.shade200)
                ]),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'City:${widget.selectedcity}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Current Gold Price per ounces:${widget.goldPrice}',
                    style: Theme.of(context).textTheme.titleSmall),
                SizedBox(
                  height: 20,
                ),
                Text('gram price:${ounsetogram.roundToDouble()}',
                    style: Theme.of(context).textTheme.titleSmall),
                SizedBox(
                  height: 20,
                ),
                Text('making price:${TotalMakingCharge}',
                    style: Theme.of(context).textTheme.titleSmall),
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Total gold  Amount',
                  style: TextStyle(color: Colors.amber, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.currency_rupee_sharp),
                    Text(totalwithGst.roundToDouble().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25,
                        )),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.5,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.yellow),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
