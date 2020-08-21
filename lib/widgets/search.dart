import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width / 3.5,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.04,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 1,
        maxLength: 16,
        maxLengthEnforced: true,
        style: TextStyle(
          fontSize: MediaQuery
              .of(context)
              .size
              .height * 0.02,
          color: Color.fromRGBO(00, 44, 64, 1),
        ),
        decoration: InputDecoration(
            filled: false,
            fillColor: Colors.teal.withOpacity(0.2),
            hintText: "Search",
            counterText: "",
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintStyle: TextStyle(
              color: Color.fromRGBO(00, 44, 64, 1),
              fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Color.fromRGBO(00, 44, 64, 1),
              size: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02,
            )),
        onChanged: (str){},
      ),
    );
  }
}
