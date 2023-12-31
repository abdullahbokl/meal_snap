import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_snap/core/utils/app_strings.dart';

import '../../models/recipe/recipe_model.dart';

class CustomFavoriteButton extends StatelessWidget {
  final RecipeInfoModel info;

  const CustomFavoriteButton({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box(AppStrings.hiveFavoriteBox).listenable(),
      builder: (context, box, child) {
        bool isFavorite = box.containsKey(info.id);
        if (isFavorite) {
          return FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              final box = Hive.box(AppStrings.hiveFavoriteBox);
              box.delete(info.id);
            },
            child: const Icon(
              Icons.favorite,
            ),
          );
        } else {
          return FloatingActionButton(
            backgroundColor: Colors.grey,
            onPressed: () {
              final box = Hive.box(AppStrings.hiveFavoriteBox);
              box.put(info.id, info.toJson());
            },
            child: const Icon(
              Icons.favorite,
            ),
          );
        }
      },
    );
  }
}
