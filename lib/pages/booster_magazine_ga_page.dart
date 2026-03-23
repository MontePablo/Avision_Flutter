import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/pages/currentaffairs_gkca_page.dart';
import 'package:avision/pages/datelist_news_appbar_page.dart';
import 'package:avision/pages/newslist_news_appbar_page.dart';
import 'package:avision/utils/Utilities.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:avision/viewmodels/magazineGaBooster_studentzone_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

void main(){
  runApp(const BoosterMagazineGaPage(data:null));
}
class BoosterMagazineGaPage extends StatefulWidget {
  const BoosterMagazineGaPage({super.key,required this.data});
  final MyEnumConstants? data;
  @override
  State<BoosterMagazineGaPage> createState() => _BoosterMagazineGaPageState();
}

class _BoosterMagazineGaPageState extends State<BoosterMagazineGaPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late MagazineGaBoosterStudentzoneViewmodel viewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    viewmodel = Provider.of<MagazineGaBoosterStudentzoneViewmodel>(context, listen: false);
    switch(widget.data!) {
      case MyEnumConstants.MONTHLY_GA_PAGE:
        viewmodel.fetchGaBooklet(context);
      case MyEnumConstants.MONTHLY_BOOSTER_PAGE:
        viewmodel.fetchBooster(context);
      case MyEnumConstants.MONTHLY_MAGAZINE_PAGE:
        viewmodel.fetchMagazine(context);
      default:
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
    viewmodel.dataMagazine=null;
    viewmodel.dataList.clear();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      if (_tabController.index == 0) {
        viewmodel.setLanguage(1);
      } else if (_tabController.index == 1) {
        viewmodel.setLanguage(2);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    String _pagetitle;
    switch(widget.data!){
      case MyEnumConstants.MONTHLY_GA_PAGE:
        _pagetitle="Monthly GA booklet";
      case MyEnumConstants.MONTHLY_BOOSTER_PAGE:
        _pagetitle="Monthly booster";
      case MyEnumConstants.MONTHLY_MAGAZINE_PAGE:
        _pagetitle="Magazine";
      default:
        _pagetitle="";
    }
    return Consumer<MagazineGaBoosterStudentzoneViewmodel>(
        builder: (BuildContext context, MagazineGaBoosterStudentzoneViewmodel value, Widget? child) {
          return DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: MyColors.blue,
                  title:
                  Text(_pagetitle, style: TextStyle(color: MyColors.white,fontSize: 16),),
                  iconTheme: const IconThemeData(
                      color: Colors.white), // Change the color here
                ),
                body:Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          color: MyColors.blue, // Grey color for the TabBar background
                          child: TabBar(
                            controller: _tabController,
                            tabs: const [
                              Tab(text: 'English',),
                              Tab(text: 'Hindi'),
                            ],
                            labelColor: Colors.orange,
                            unselectedLabelColor: Colors.white,
                            indicatorColor: Colors.orange, // Blue color for the indicator
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                              physics:const ScrollPhysics(),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: viewmodel.dataList.length,
                                  itemBuilder: (context, index) {
                                    return MyMagazineItem(
                                        mag: viewmodel
                                            .dataList
                                            .elementAt(index));
                                  })
                          ),
                        )
                      ],
                    ),
                    Center(
                      child: Visibility(
                        visible: viewmodel.isLoading,
                        child:  SpinKitFadingCircle(color: MyColors.blue,size: MyConstants.sh*.1,),
                      ),
                    ),
                  ]
                )
            ),
          );
        }
    );
  }
}
