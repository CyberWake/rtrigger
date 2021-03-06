import 'package:flutter/material.dart';
import 'package:user/widgets/vendor_card.dart';
import 'package:user/services/Food/vendor_fetching.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';

class VendorScreen extends StatefulWidget {
  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  VendorFetching vendorFetching = VendorFetching();
  List<dynamic> vendorData = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getVendorData().whenComplete(() {
      setState(() {
        isLoaded = true;
      });
    });
  }

  Future<void> getVendorData() async {
    var fetchedData = await vendorFetching.getVendors();
    setState(() {
      vendorData = fetchedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UniversalAppBar(
          context,
          true,
          'All Vendors',
        ),
        body: isLoaded
            ? SafeArea(
                child: ListView.builder(
                itemBuilder: (context, index) {
                  return VendorCard(
                    vendorID: vendorData[index]["userId"],
                    type: vendorData[index]["desc"],
                    name: vendorData[index]["name"],
                    distance: vendorData[index]["distance"].toString(),
                    image: vendorData[index]["imageUrl"],
                  );
                },
                itemCount: vendorData.length,
              ))
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Please Wait...")
                  ],
                ),
              ));
  }
}
