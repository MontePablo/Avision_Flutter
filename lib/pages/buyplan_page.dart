import 'package:avision/data_models/buyPlanRequest.dart';
import 'package:avision/utils/Utilities.dart';
import 'package:avision/viewmodels/buyplan_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../custom_widgets/my_custom_widgets.dart';
import '../data_models/planlist_buyplan_response.dart';
import '../storage/shared_preferences.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

void main() {
  runApp(const BuyplanPage());
}

class BuyplanPage extends StatefulWidget {
  const BuyplanPage({super.key});

  @override
  State<BuyplanPage> createState() => _RecordedVideosDrawerPageState();
}

class _RecordedVideosDrawerPageState extends State<BuyplanPage> {
  late BuyplanViewmodel buyplanViewmodel;
  late Razorpay _razorpay;
  String mobileNo="6289818141";
  String email="avisioninstitute@gmail.com";
  int selectedPackage=-1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buyplanViewmodel = Provider.of<BuyplanViewmodel>(context, listen: false);
    _razorpay = Razorpay();

    // Set up event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }

  @override
  void dispose() {
    _razorpay.clear(); // Dispose the Razorpay instance to avoid memory leaks
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      buyplanViewmodel.fetchBanner(context);
      buyplanViewmodel.fetchPlanlist(context);
      buyplanViewmodel.fetchCourselist(context);
      buyplanViewmodel.fetchStudentreviewlist(context);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BuyplanViewmodel>(
        builder: (BuildContext context, BuyplanViewmodel value, Widget? child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (buyplanViewmodel.dataBuyplanResponse != null && buyplanViewmodel.dataBuyplanResponse?.statusCode=="203") {
              Utility.flushbarPositiveMsg("duck", context);
            }
          });
      return Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.blue,
            title: const Text(
              "Plans",
              style: TextStyle(color: MyColors.white, fontSize: 20),
            ),

            iconTheme: const IconThemeData(
                color: Colors.white), // Change the color here
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(children: [
                  buyplanViewmodel.dataBanner != null
                      ? CarouselSlider.builder(
                          itemCount:
                              buyplanViewmodel.dataBanner!.banner!.length,
                          itemBuilder:
                              (BuildContext context, int index, int realIndex) {
                            return MySliderImage(
                              image: buyplanViewmodel.dataBanner!.banner!
                                  .elementAt(index)
                                  .bannerImage!,
                            );
                          },
                          options: CarouselOptions(
                            aspectRatio: 16 / 7,
                            viewportFraction: 0.95,
                            autoPlay: true,
                          ),
                        )
                      : const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("One Pass. All Exams. Unlimited Tests.",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                        SizedBox(height: MyConstants.sh*.01,),
                        Text("Banking & Insurance,SSC & Railways and more"),
                        Text("Buy Pass & Unlock all tests"),
                        SizedBox(height: MyConstants.sh*.05,),
                        Text("Choose One Package for you :",style: TextStyle(fontWeight: FontWeight.bold),),
                        buyplanViewmodel.dataPlanlist!=null
                            ?ListView.builder(
                          physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: buyplanViewmodel
                                .dataPlanlist!.notificationList!.length,
                            itemBuilder: (context, index) {
                             Plans item=buyplanViewmodel
                                 .dataPlanlist!.notificationList!
                                 .elementAt(index);
                              return MyBuyPlans(
                                  plan: item,isSelected: selectedPackage==index?true:false,onClick: (){
                                selectedPackage=index;
                                Utility.showCustomDialog(context,  MyPriceClickDialog(plan: buyplanViewmodel.dataPlanlist!.notificationList!.elementAt(index),onClick: (){
                                  openCheckout(int.parse(item.offerPrice!));
                                },));
                                setState(() {});
                              },);
                            }):const SizedBox.shrink(),
                        Text("Get all tests listed below and more.."),
                        buyplanViewmodel.dataCourselist!=null?
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount:buyplanViewmodel!.dataCourselist!.notificationList!.length ,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            // crossAxisSpacing: 10,
                            // mainAxisSpacing: 10,
                          ),
                          physics:const ScrollPhysics(),
                          itemBuilder: (context,index){
                            return MyCourseBuyplan(course: buyplanViewmodel.dataCourselist!.notificationList!.elementAt(index));
                          },
                        ):Center(),
                        Text("Why Join Avision ?",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.white70, Colors.grey],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15), // optional for rounded corners
                          ),
                           child:  Padding(
                             padding: const EdgeInsets.all(12.0),
                             child: Column(
                               children: [
                                 const Text("Still Not Sure ? Don't Worry!",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                                 SizedBox(height: MyConstants.sh*.01,),
                                 const  Text("Please connect with us and we will try our best to assist you!",textAlign: TextAlign.center,),
                                 SizedBox(height: MyConstants.sh*.01,),

                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                     InkWell(
                                       onTap: (){},
                                       child: Container(
                                         width: MyConstants.sw*.35,
                                         height: MyConstants.sh*.05,
                                         decoration: BoxDecoration(
                                           color: MyColors.white,
                                           borderRadius: BorderRadius.circular(10),
                                           boxShadow: [
                                             BoxShadow(
                                               color: MyColors.grey.withOpacity(0.5),
                                               blurStyle: BlurStyle.normal,
                                               spreadRadius: 3,
                                               blurRadius: 2,
                                               offset: const Offset(2, 2), // changes position of shadow
                                             ),
                                           ],
                                         ),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                           children: [
                                             SizedBox(
                                               child: Image.asset("assets/images/dialer_logo.png"),
                                               height: MyConstants.sh*.07,
                                               width: MyConstants.sw*.07,
                                             ),
                                             Text(mobileNo)
                                           ],
                                         ),
                                       ),
                                     ),
                                     InkWell(
                                       onTap: (){},
                                       child: Container(
                                         width: MyConstants.sw*.35,
                                         height: MyConstants.sh*.05,
                                         decoration: BoxDecoration(
                                           color: MyColors.white,
                                           borderRadius: BorderRadius.circular(10),
                                           boxShadow: [
                                             BoxShadow(
                                               color: MyColors.grey.withOpacity(0.5),
                                               blurStyle: BlurStyle.normal,
                                               spreadRadius: 3,
                                               blurRadius: 2,
                                               offset: const Offset(2, 2), // changes position of shadow
                                             ),
                                           ],
                                         ),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                           children: [
                                             SizedBox(
                                               child: Image.asset("assets/images/dialer_logo.png"),
                                               height: MyConstants.sh*.07,
                                               width: MyConstants.sw*.07,
                                             ),
                                             Text(mobileNo)
                                           ],
                                         ),
                                       ),
                                     )
                                   ],
                                 )
                               ],
                             ),
                           ),
                         ),
                         const Text("Student Reviews",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                        buyplanViewmodel.dataStudentreviews != null
                            ?
                   
                        CarouselSlider.builder(
                          itemCount: buyplanViewmodel.dataStudentreviews!.result!.length,
                          itemBuilder: (BuildContext context, int index, int realIndex) {
                            return MyStudentreview(
                              studentreview: buyplanViewmodel.dataStudentreviews!.result!.elementAt(index),
                            );
                          },
                          options: CarouselOptions(
                              aspectRatio: 16/11,
                              viewportFraction: 0.9,
                              autoPlay: true,
                          ),
                        )
                            : const SizedBox.shrink(),

                      ],
                    ),
                  ),
                ]),
              ),
              Center(
                child: Visibility(
                  visible: buyplanViewmodel.isLoading,
                  child: SpinKitFadingCircle(
                    color: MyColors.blue,
                    size: MyConstants.sh * .1,
                  ),
                ),
              ),
            ],
          ));
    });
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    var userId=(await MySharedPreferences().getUserDetail())?.userId;
    var planId=buyplanViewmodel.dataPlanlist!.notificationList![selectedPackage].planId!;
    buyplanViewmodel.setPlan(context, BuyPlanRequest(
        studentId: userId!,
        productId: planId,
        productType: "2"
    ));
    // ScaffoldMessenger.of(context).showSnackBar(
    //   Utility.flushbarPositiveMsg('Payment Successful: ${response.paymentId}', context),
    // );
  }

  Future<void> _handlePaymentError(PaymentFailureResponse response) async {
    var userId=(await MySharedPreferences().getUserDetail())?.userId;
    var planId=buyplanViewmodel.dataPlanlist!.notificationList![selectedPackage].planId!;
    buyplanViewmodel.setPlan(context, BuyPlanRequest(
        studentId: userId!,
        productId: planId,
        productType: "2"
    ));
    // ScaffoldMessenger.of(context).showSnackBar(
    // Utility.flushbarErrorMsg('Payment Failed: ${response.message}', context),
    // );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection
    ScaffoldMessenger.of(context).showSnackBar(
        Utility.flushbarPositiveMsg('External Wallet Selected: ${response.walletName}', context)
    );
  }

  void openCheckout(int amount) {
    Navigator.of(context).pop();
    var options = {
      'key': 'rzp_live_uv8xHezKpGvUh6', // Replace with your Key ID
      'amount': amount * 100, // Amount in paise (e.g., ₹100 = 10000 paise)
      'name': 'Avision Institute',
      'description': 'Buy Avision Plan ',
      'prefill': {
        'contact': mobileNo,
        'email': email,
      },
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

}
