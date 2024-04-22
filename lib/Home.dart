import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:goldjewel/Total.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchGoldPrice();
  }

  fetchGoldPrice() async {
    final apikey = 'goldapi-uza96sltthot7l-io';
    Uri url = Uri.parse('https://www.goldapi.io/api/XAU/INR');
    final response = await http.get(url, headers: {'x-access-token': apikey});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        goldPrice = data['price'];
        print(goldPrice);
      });
      return goldPrice;
    }
  }

  Future<void> _refreshData() async {
    await fetchGoldPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: SafeArea(
            child: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height / 18,
                color: Colors.grey.shade200,
                // margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.diamond_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Gold Jewel',
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
              ),
              Heading(context),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                height: MediaQuery.sizeOf(context).height / 1.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customTabbar(),
                    Expanded(
                      child: TabBarView(
                          children: [TabView1(context), Text('Saf')]),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Padding TabView1(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomForm(
                DropdownButton<String>(
                  hint: Text(
                    'Select City',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  value: _selectedValue,
                  underline: SizedBox(),
                  isExpanded: true,
                  iconSize: 0,
                  items: <String>[
                    'Calicut',
                    'Mumbai',
                    'Dubai',
                    'London',
                    'USA',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: Theme.of(context).textTheme.bodySmall,
                        ));
                  }).toList(),
                  onChanged: (newvalue) {
                    setState(() {
                      _selectedValue = newvalue!;
                    });
                    print(_selectedValue);
                  },
                ),
                'Select City'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enter Weight of Gold',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 50,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 0.0),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: TextFormField(
                        controller: weight,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Empty Field';
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.symmetric(vertical: 0)),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 40,
                      width: 75,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: DropdownButton(
                        value: Gold,
                        underline: SizedBox(),
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconSize: 20,
                        items: <String>['Grams', 'Ounces']
                            .map((e) => DropdownMenuItem(
                                  child: Text(
                                    e,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            Gold = value;
                            print(Gold);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CustomForm(
                DropdownButton(
                  value: Carat,
                  underline: SizedBox(),
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 20,
                  items: <String>['22 Carat', '24 Carat']
                      .map((e) => DropdownMenuItem(
                            child: Text(
                              e,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      Carat = value;
                      print(Carat);
                    });
                  },
                ),
                'Select the Gold Carat'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Gold Price',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Container(
                  height: 40,
                  width: 130,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey.shade100),
                  child: Row(
                    children: [
                      Icon(
                        Icons.currency_rupee_rounded,
                        size: 15,
                      ),
                      Text(
                        goldPrice.toString(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Wastage',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 80,
                      child: TextFormField(
                        controller: wastage,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Empty Field';
                          }
                        },
                        decoration: InputDecoration(isDense: true),
                      ),
                    ),
                    Icon(
                      Icons.percent_outlined,
                      size: 20,
                    ),
                    SizedBox(
                      width: 30,
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Making Charges',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 50,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Empty Field';
                          }
                        },
                        controller: charge,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 40,
                      width: 75,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: DropdownButton(
                        value: Charge,
                        underline: SizedBox(),
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconSize: 20,
                        items: <String>['Grams', 'Ounces']
                            .map((e) => DropdownMenuItem(
                                  child: Text(
                                    e,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            Charge = value;
                            print(Charge);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'GST(CGST+SGST)',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Row(
                  children: [
                    Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Center(child: Text('3%'))),
                    SizedBox(
                      width: 70,
                    )
                  ],
                ),
              ],
            ),
            CustomButton(context)
          ],
        ),
      ),
    );
  }

  TabBar customTabbar() {
    return const TabBar(
      tabs: [
        SizedBox(
          width: double.infinity,
          child: Tab(
            child: Text('With stone'),
          ),
        ),
        SizedBox(
            width: double.infinity, child: Tab(child: Text('Withot stone')))
      ],
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.white,

      // indicatorColor:
      indicator: BoxDecoration(
          color: Color.fromARGB(197, 239, 138, 120),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
    );
  }

  Center Heading(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            'DON\'T LOSE',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                ),
          ),
          Text(
            'YOUR MONEY!!',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.red,
                ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Use your Gold Price Calculator Now for\nSmart Financial Choices',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    ));
  }

  TextEditingController weight = TextEditingController();
  TextEditingController charge = TextEditingController();
  TextEditingController wastage = TextEditingController();
  final key = GlobalKey<FormState>();
  String? _selectedValue;
  String? Carat = '24 Carat';
  String? Gold = 'Grams';
  var goldPrice;
  String? Charge = 'Grams';

  Center CustomButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width / 1.3,
        child: ElevatedButton(
          onPressed: () {
            if (key.currentState!.validate()) {
              // totalAmount(weight.text, charge.text, goldPrice);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Total(
                    weight: weight.text,
                    charge: charge.text,
                    wastage: wastage.text,
                    selectedcity: _selectedValue,
                    carat: Carat,
                    gold: Gold,
                    goldPrice: goldPrice,
                    Chargegrm: Charge),
              ));
            }
          },
          child: Text(
            'Calculate',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.yellow),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
        ),
      ),
    );
  }

  Row CustomForm(Widget? child, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Container(
          height: 40,
          width: 130,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.grey.shade100),
          child: Center(child: child),
        ),
      ],
    );
  }
}
