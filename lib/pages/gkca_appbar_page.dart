import 'package:avision/pages/currentaffairs_gkca_page.dart';
import 'package:avision/pages/quizlist_gkca_page.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

void main(){
  runApp(const GkcaAppbarPage());
}
class GkcaAppbarPage extends StatefulWidget {
  const GkcaAppbarPage({super.key});

  @override
  State<GkcaAppbarPage> createState() => _GkcaAppbarPageState();
}

class _GkcaAppbarPageState extends State<GkcaAppbarPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.blue,
          title: const Text("General Knowledge & Current Affairs",style: TextStyle(color: MyColors.white,fontSize: 16),),

          iconTheme: const IconThemeData(
              color: Colors.white), // Change the color here
        ),
         body:Column(
           children: [
             Container(
               color: MyColors.blue, // Grey color for the TabBar background
               child: TabBar(
                 controller: _tabController,
                 tabs: [
                   Tab(text: 'Current Affairs',),
                   Tab(text: 'GK Quizzes'),
                 ],
                 labelColor: Colors.orange,
                 unselectedLabelColor: Colors.white,
                 indicatorColor: Colors.orange, // Blue color for the indicator
               ),
             ),
             Expanded(
               child: TabBarView(
                 controller: _tabController,
                 children: const [
                   CurrentAffairsGkcaPage(),
                   QuizlistGkcaPage(),
                 ],
               ),
             ),
           ],
         )
      ),
    );
  }
}
