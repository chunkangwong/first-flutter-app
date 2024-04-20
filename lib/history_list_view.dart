import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';

class HistoryListView extends StatefulWidget {
  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  final _key = GlobalKey();

  static const Gradient _maskingGradient = LinearGradient(
    // This gradient goes from fully transparent to fully opaque black...
    colors: [Colors.transparent, Colors.black],
    // ... from the top (transparent) to half (0.5) of the way to the bottom.
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    appState.historyListKey = _key;

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: EdgeInsets.only(top: 100),
        initialItemCount: appState.history.length,
        itemBuilder: (context, index, animation) {
          final pair = appState.history[index];
          return SizeTransition(
              sizeFactor: animation,
              child: Center(
                  child: TextButton.icon(
                onPressed: () {
                  appState.toggleFavourite();
                },
                label: Text(
                  pair.asLowerCase,
                  semanticsLabel: pair.asPascalCase,
                ),
                icon: appState.favourites.contains(pair)
                    ? Icon(Icons.favorite, size: 12)
                    : SizedBox(),
              )));
        },
      ),
    );
  }
}
