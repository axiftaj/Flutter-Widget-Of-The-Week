


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterListViewBuilderWidget extends StatefulWidget {
  const FilterListViewBuilderWidget({Key? key}) : super(key: key);

  @override
  State<FilterListViewBuilderWidget> createState() => _FilterListViewBuilderWidgetState();
}

class _FilterListViewBuilderWidgetState extends State<FilterListViewBuilderWidget> {

  TextEditingController controller =  TextEditingController();

  List<Users> list = [
    Users(name: "Asif Taj" ,subTitle: 'Flutter developer', image: "https://cdn.pixabay.com/photo/2016/11/21/14/53/man-1845814_960_720.jpg" , isFavourite: true),
    Users(name: "John" ,subTitle: 'Github.com', image: "https://cdn.pixabay.com/photo/2015/01/06/16/14/woman-590490_960_720.jpg" , isFavourite: true),
    Users(name: "Alina" ,subTitle: 'Marketing guy', image: "https://cdn.pixabay.com/photo/2017/04/05/10/45/girl-2204622_960_720.jpg" , isFavourite: false),
    Users(name: "Escort" , subTitle: 'Java developer',image: "https://cdn.pixabay.com/photo/2017/12/01/08/02/paint-2990357_960_720.jpg" , isFavourite: true),
    Users(name: "Dave Johnson" , subTitle: 'Blockchain is new trend',image: "https://cdn.pixabay.com/photo/2016/03/26/22/13/man-1281562_960_720.jpg" , isFavourite: true),
    Users(name: "John Elia" ,subTitle: 'Exploring world', image: "https://cdn.pixabay.com/photo/2020/05/17/20/21/cat-5183427_960_720.jpg" , isFavourite: false),
    Users(name: "Aizaz khan" ,subTitle: 'TRS on Fiverr', image: "https://cdn.pixabay.com/photo/2021/11/09/15/54/man-6781827_960_720.jpg" , isFavourite: false),
    Users(name: "Burlin" ,subTitle: 'Money hiest', image: "https://cdn.pixabay.com/photo/2021/03/02/16/34/woman-6063087_960_720.jpg" , isFavourite: true),
    Users(name: "John Wick" ,subTitle: 'Who kill my dog', image: "https://cdn.pixabay.com/photo/2020/05/17/20/21/cat-5183427_960_720.jpg" , isFavourite: false),
    Users(name: "Tokyo" ,subTitle: 'Capital of Japan', image: "https://cdn.pixabay.com/photo/2021/05/01/09/59/city-6220689_960_720.jpg" , isFavourite: true),

  ] ;

  //source code github.com/axiftaj
  // check widget of the week repo

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                  child: CupertinoSearchTextField(
                    placeholder: 'Search',

                    onChanged: (value){
                      setState(() {});
                    },
                    onSubmitted: (value){
                    },
                    controller: controller,
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context , index){
                          String name = list[index].name ;

                          if(controller.text.isEmpty){
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(list[index].image),
                              ),
                              title: Text(list[index].name),
                              subtitle: Text(list[index].subTitle),

                              trailing: list[index].isFavourite ?  Icon(Icons.favorite , color: Colors.red.shade600,) : Icon(Icons.favorite_border),
                            );
                          }else if(name.toLowerCase().contains(controller.text.toLowerCase())){
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(list[index].image),
                              ),
                              title: Text(list[index].name),
                              subtitle: Text(list[index].subTitle),

                              trailing: list[index].isFavourite ?  Icon(Icons.favorite , color: Colors.red.shade600,) : Icon(Icons.favorite_border),
                            );

                          }else {
                            return Container();
                          }

                        }))
              ],

            ),
          ),
        ),
      ),
    );
  }
}


class Users {

  String name, image , subTitle  ;
  bool isFavourite;

  Users({required this.name , required this.isFavourite , required this.image , required this.subTitle});
}