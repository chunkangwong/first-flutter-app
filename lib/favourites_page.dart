import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();
    var favourites = appState.favourites;

    if (favourites.isEmpty) {
      return Center(child: Text("No favourites yet"));
    }

    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Text("You have ${favourites.length} favourites")),
        for (var favourite in favourites)
          ListTile(
            leading: IconButton(
              icon: Icon(Icons.delete_outline, semanticLabel: 'Delete'),
              color: theme.colorScheme.primary,
              onPressed: () {
                appState.removeFavourite(favourite);
              },
            ),
            title: Text(
              favourite.asLowerCase,
              semanticsLabel: favourite.asPascalCase,
            ),
          )
      ],
    );
  }
}
