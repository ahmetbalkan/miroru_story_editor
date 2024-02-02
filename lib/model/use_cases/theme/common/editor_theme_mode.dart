import 'package:flutter/material.dart';
import 'package:miroru_story_editor/model/entities/decoration/decorations/background_image/background_image.dart';
import 'package:miroru_story_editor/model/use_cases/decoration/decoration_palette_state.dart';
import 'package:miroru_story_editor/util/get_theme_from_image.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'editor_theme_mode.g.dart';

@Riverpod(keepAlive: true)
class EditorThemeMode extends _$EditorThemeMode {
  @override
  ThemeMode build() {
    final backgroundImageObject =
        ref.watch(decorationPaletteStateProvider).backgroundImage;

    final backgroundImageData =
        backgroundImageObject.data as DecorationBackgroundImage;

    final backgroundImageFile = backgroundImageData.backgroundImageFile;

    if (backgroundImageFile == null) {
      return ThemeMode.dark;
    }

    final data = getThemeFromImage(backgroundImageFile);
    return data;
  }
}
