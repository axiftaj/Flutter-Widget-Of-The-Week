

import 'package:flutter/material.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget({Key? key}) : super(key: key);

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {

  bool isExpanded = false ;
  String selectedValue = 'Select option' ;

  //list that will be expanded
  List<String> politicsList = ['Left Wing', 'Liberal', 'Moderate', 'Conservative', 'Libertarian', 'Apolitical'] ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drop Down'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(

            children: [
              SizedBox(height: 150,),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(5),
                    topRight: const Radius.circular(5),
                    bottomLeft: Radius.circular( isExpanded ? 0 : 5),
                    bottomRight: Radius.circular(isExpanded ? 0 :5),

                  ),

                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: InkWell(
                        onTap: (){
                          FocusScope.of(context).unfocus();
                          isExpanded = !isExpanded;
                          setState(() {

                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(selectedValue, style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16))),
                            Icon( isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down ,
                              color: isExpanded  ? Colors.red : Colors.blue,
                            )
                          ],
                        )),
                  ),
                ),
              ),
              if(isExpanded)
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: politicsList.map((e) =>
                      InkWell(
                        onTap: (){
                          isExpanded = false ;
                          selectedValue = e ;
                          setState(() {

                          });
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: selectedValue == e ? Colors.pink: Colors.grey.shade300,

                            ),
                            child: Center(child: Text(e.toString() ,
                              style:Theme.of(context).textTheme.headline2!.copyWith(
                                  fontSize: 14,
                                  color: selectedValue == e  ? Colors.black : Colors.blue
                              ) ,))
                        ),
                      )
                  ).toList(),
                )
            ],
          ),
        ),
      ),
    );

  }

}
