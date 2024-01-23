import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:miroru_story_editor/extensions/color_extension.dart';
import 'package:miroru_story_editor/extensions/context_extension.dart';
import 'package:miroru_story_editor/extensions/string_extension.dart';
import 'package:miroru_story_editor/model/entities/decorations/text/decoration_text.dart';
import 'package:miroru_story_editor/model/entities/render_item/render_item.dart';
import 'package:miroru_story_editor/model/enums/font_type.dart';
import 'package:miroru_story_editor/model/use_cases/palette/palette_state.dart';
import 'package:miroru_story_editor/presentation/views/decoration/text/text_size_slider_view.dart';
import 'package:miroru_story_editor/presentation/views/decoration/text/text_tool_header_view.dart';
import 'package:miroru_story_editor/presentation/widgets/decoration/text/color_list_selector_view.dart';
import 'package:miroru_story_editor/presentation/widgets/decoration/text/font_list_selector_view.dart';
import 'package:uuid/uuid.dart';

class TextEditingView extends HookConsumerWidget {
  const TextEditingView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textItem = useState<RenderItem<DecorationText>>(
      RenderItem<DecorationText>(
        transform: Matrix4.identity(),
        data: DecorationText(
          fontFamily: FontType.roboto.name,
          backgroundColorCode: Colors.black.hex,
          fontSize: 20,
          colorCode: Colors.white.hex,
        ),
        uuid: const Uuid().v4(),
        order: 0,
      ),
    );

    final isColorEditing = useState<bool>(false);

    // 関数の中は再度インスタンスを生成する必要がある
    final decorationText = textItem.value.data as DecorationText;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        context.hideKeyboard();

        final data = textItem.value.data as DecorationText;
        if (!(data.text?.isNotEmpty ?? false)) {
          ref.read(paletteStateProvider.notifier).changeEditingText(
                false,
              );

          return;
        }
        ref.read(paletteStateProvider.notifier).addRenderItem(
              textItem.value,
            );
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
              child: TextToolHeaderView(
                renderItem: textItem.value,
                onColor: () {
                  isColorEditing.value = !isColorEditing.value;
                },
                changeTextAlign: () {
                  if (textItem.value.data is! DecorationText) {
                    throw Exception(
                      'textItem.value.data is not DecorationText',
                    );
                  }
                  late final TextAlign newAlignment;

                  if (decorationText.textAlign == TextAlign.left.name) {
                    newAlignment = TextAlign.center;
                  } else if (decorationText.textAlign ==
                      TextAlign.center.name) {
                    newAlignment = TextAlign.right;
                  } else if (decorationText.textAlign == TextAlign.right.name) {
                    newAlignment = TextAlign.left;
                  } else {
                    newAlignment = TextAlign.left;
                  }

                  final newDecorationText =
                      textItem.value.data as DecorationText;
                  textItem.value = RenderItem<DecorationText>(
                    transform: textItem.value.transform,
                    data: newDecorationText.copyWith(
                      textAlign: newAlignment.name,
                    ),
                    uuid: textItem.value.uuid,
                    order: textItem.value.order,
                  );
                },
                changeFillColor: () {
                  if (textItem.value.data is! DecorationText) {
                    throw Exception(
                      'textItem.value.data is not DecorationText',
                    );
                  }
                  late final Color newBackgroundColor;

                  if (decorationText.backgroundColorCode.toColor ==
                      Colors.black) {
                    newBackgroundColor = Colors.white;
                  } else {
                    newBackgroundColor = Colors.black;
                  }

                  final newDecorationText =
                      textItem.value.data as DecorationText;
                  textItem.value = RenderItem<DecorationText>(
                    transform: textItem.value.transform,
                    data: newDecorationText.copyWith(
                      backgroundColorCode: newBackgroundColor.hex,
                    ),
                    uuid: textItem.value.uuid,
                    order: textItem.value.order,
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextSizeSliderView(
                fontSize: decorationText.fontSize ?? 20,
                onChangeFontSize: (double fontSize) {
                  if (textItem.value.data is! DecorationText) {
                    throw Exception(
                      'textItem.value.data is not DecorationText',
                    );
                  }
                  final newDecorationText =
                      textItem.value.data as DecorationText;
                  textItem.value = RenderItem<DecorationText>(
                    transform: textItem.value.transform,
                    data: newDecorationText.copyWith(
                      fontSize: fontSize,
                    ),
                    uuid: textItem.value.uuid,
                    order: textItem.value.order,
                  );
                },
              ),
            ),
            Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: IntrinsicWidth(
                  child: TextField(
                    autofocus: true,
                    onChanged: (value) {
                      if (textItem.value.data is! DecorationText) {
                        throw Exception(
                          'textItem.value.data is not DecorationText',
                        );
                      }
                      final newDecorationText =
                          textItem.value.data as DecorationText;
                      textItem.value = RenderItem<DecorationText>(
                        transform: textItem.value.transform,
                        data: newDecorationText.copyWith(
                          text: value,
                        ),
                        uuid: textItem.value.uuid,
                        order: textItem.value.order,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Aa',
                      fillColor: decorationText.backgroundColorCode.toColor,
                      hintStyle: TextStyle(
                        fontSize: decorationText.fontSize,
                        color:
                            decorationText.colorCode.toColor.withOpacity(0.5),
                      ),
                    ),
                    maxLines: null,
                    style: decorationText.fontFamily.fontStyle.copyWith(
                      fontSize: decorationText.fontSize,
                      color: decorationText.colorCode.toColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: isColorEditing.value
              ? ColorListSelectorWidget(
                  selectedColor: decorationText.colorCode.toColor,
                  onChangeColor: (color) {
                    if (textItem.value.data is! DecorationText) {
                      throw Exception(
                        'textItem.value.data is not DecorationText',
                      );
                    }
                    final newDecorationText =
                        textItem.value.data as DecorationText;
                    textItem.value = RenderItem<DecorationText>(
                      transform: textItem.value.transform,
                      data: newDecorationText.copyWith(
                        colorCode: color.hex,
                      ),
                      uuid: textItem.value.uuid,
                      order: textItem.value.order,
                    );
                  },
                )
              : FontListSelectorWidget(
                  onChangeFontName: (fontName) {
                    if (textItem.value.data is! DecorationText) {
                      throw Exception(
                        'textItem.value.data is not DecorationText',
                      );
                    }
                    final newDecorationText =
                        textItem.value.data as DecorationText;
                    textItem.value = RenderItem<DecorationText>(
                      transform: textItem.value.transform,
                      data: newDecorationText.copyWith(
                        fontFamily: fontName,
                      ),
                      uuid: textItem.value.uuid,
                      order: textItem.value.order,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
