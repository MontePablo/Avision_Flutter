import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/newsListNewsAppbarRequest.dart';
import 'package:avision/utils/Utilities.dart';
import 'package:avision/viewmodels/news_appbar_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

class NewsListNewsAppbarPage extends StatefulWidget {
  final ValueNotifier<DateTime?> valueNotifier;

  const NewsListNewsAppbarPage({super.key, required this.valueNotifier});

  @override
  State<NewsListNewsAppbarPage> createState() => _NewsListNewsAppbarPageState();
}

class _NewsListNewsAppbarPageState extends State<NewsListNewsAppbarPage> {
  late NewsAppbarViewmodel newsAppbarViewmodel;

  @override
  void initState() {
    super.initState();
    newsAppbarViewmodel = Provider.of<NewsAppbarViewmodel>(context, listen: false);
    // newsAppbarViewmodel.fetchLastdateNewsList(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    newsAppbarViewmodel.dataNewsList=null;

    super.dispose();
  }

  void fetchNewsForDate(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    newsAppbarViewmodel.fetchNewsList(context, NewsListNewsAppbarRequest(detailsDate: formattedDate));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DateTime?>(
      valueListenable: widget.valueNotifier,
      builder: (context, date, child) {
        // Fetch news for the updated date
        if(date!=null){
          fetchNewsForDate(date);
          print(date.toString());
        }else{
          newsAppbarViewmodel.fetchLastdateNewsList(context);
        }

        return Consumer<NewsAppbarViewmodel>(
          builder: (BuildContext context, NewsAppbarViewmodel value, Widget? child) {
            return Scaffold(
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              newsAppbarViewmodel.dataNewsList!=null
                              ?Text(Utility().formatDate(DateFormat('yyyy-MM-dd').format(newsAppbarViewmodel.dataNewsList!.newsAnalysis!.datUrl!.elementAt(0).postedDate!))):const SizedBox.shrink(),
                              InkWell(
                                 onTap: (){
                                   if(newsAppbarViewmodel.dataNewsList!=null) {
                                     Utility().downloadFile(
                                         newsAppbarViewmodel.dataNewsList!
                                             .newsAnalysis!
                                             .datUrl!
                                             .elementAt(0)
                                             .pdfUrl!, context);
                                   }
                                   },
                                  child: const Icon(Icons.download_for_offline, color: Colors.deepOrange, size: 35)),
                            ],
                          ),
                          SizedBox(height: MyConstants.sh * 0.01),
                          newsAppbarViewmodel.dataNewsList != null
                              ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: newsAppbarViewmodel.dataNewsList!.newsAnalysis!.titleContent!.length,
                            itemBuilder: (context, index) {
                              return MyNewsItemNewsAppbar(
                                news: newsAppbarViewmodel.dataNewsList!.newsAnalysis!.titleContent!.elementAt(index),
                              );
                            },
                          )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Visibility(
                      visible: newsAppbarViewmodel.isLoading,
                      child: SpinKitFadingCircle(
                        color: MyColors.blue,
                        size: MyConstants.sh * .1,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}