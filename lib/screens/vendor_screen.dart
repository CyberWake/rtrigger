import 'package:flutter/material.dart';
import 'package:user/widgets/vendor_card.dart';
import 'package:user/services/Food/vendor_fetching.dart';

class VendorScreen extends StatefulWidget {
  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {

  VendorFetching vendorFetching = VendorFetching();
  List<dynamic> vendorData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVendorData();
  }

  void getVendorData() async{
    var fetchedData = await vendorFetching.getVendors();
    setState(() {
      vendorData = fetchedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendors"),
      ),
      body: SafeArea(
          child: ListView.builder(
            itemBuilder: (context, index){
              return VendorCard(
                vendorID: vendorData[index]["vendorID"],
                type: vendorData[index]["desc"],
                name: vendorData[index]["name"],
                distance: vendorData[index]["distance"],
                image: vendorData[index]["image"],
              );
            },
            itemCount: vendorData.length,
          )
      ),
    );
  }
}
