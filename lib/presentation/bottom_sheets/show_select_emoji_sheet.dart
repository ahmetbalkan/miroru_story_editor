import 'package:flutter/material.dart';
import 'package:miroru_story_editor/presentation/bottom_sheets/common/show_sliver_drag_sheet.dart';
import 'package:miroru_story_editor/util/vibration.dart';
import 'package:unicode_emojis/unicode_emojis.dart';

Future<String?> showSelectEmojiSheet(
  BuildContext context,
) {
  const emojis = UnicodeEmojis.allEmojis;
  return showSliverDragSheet(
    context,
    initialChildSize: 0.6,
    slivers: [
      SliverGrid.count(
        crossAxisCount: 6,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: emojis
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Vibration.call();
                  Navigator.of(context).pop(e.emoji);
                },
                child: Center(
                  child: Text(
                    e.emoji,
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    ],
  );
}
