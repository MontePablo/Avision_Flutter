import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/PostsFeedRequest.dart';
import 'package:avision/utils/constants.dart';
import 'package:avision/viewmodels/feed_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';


class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late FeedViewModel feedViewModel;
  final ScrollController _scrollController = ScrollController();
  int _pageIndex = 1;

  @override
  void initState() {
    super.initState();
    feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !feedViewModel.isLoading) {
        _pageIndex++;
        feedViewModel.fetchPosts(context, PostsFeedRequest(pageIndex: _pageIndex.toString()));
      }
    });

    // Initial data fetch
    feedViewModel.fetchPosts(context, PostsFeedRequest(pageIndex: _pageIndex.toString()));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedViewModel>(
      builder: (BuildContext context, FeedViewModel value, Widget? child) {
        return Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  feedViewModel.dataPostList.isNotEmpty?
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: feedViewModel.dataPostList.length,
                      itemBuilder: (context, index) {
                        return MyPostItem(post: feedViewModel.dataPostList.elementAt(index));
                      },
                    ):const SizedBox.shrink(),
                  if (feedViewModel.isLoading)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: SpinKitFadingCircle(
                        color: MyColors.blue,
                        size: MyConstants.sh * 0.1,
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}