import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  final String listType;

  Refresh({this.child, this.listType});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return RefreshIndicator(
      color: Color(0xFF626EE3),
      backgroundColor: Color(0xFF001528),
      strokeWidth: 2.0,
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        switch(listType) {
          case 'newest': await bloc.fetchNewestIds();
          break;
          case 'best': await bloc.fetchBestIds();
          break;
          case 'top': await bloc.fetchTopIds();
          break;
        }
      },
    );
  }
}