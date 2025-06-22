import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/enums/theme_enums.dart';
import 'package:movies/presentation/view_models/theme/theme_provider.dart';

class AppColorToggle extends ConsumerWidget {
  const AppColorToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return IconButton(
      icon: Icon(Icons.color_lens, color: themeState.themeColor.toColor()),
      tooltip: 'Change theme color',
      onPressed: () async {
        await _showColorPicker(context, ref);
      },
    );
  }

  Future<void> _showColorPicker(BuildContext context, WidgetRef ref) async {
    final currentColor = ref.read(themeProvider).themeColor;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Theme Color'),
          content: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: ThemeColorEnum.values.map((color) {
              return GestureDetector(
                onTap: () async {
                  await ref
                      .read(themeProvider.notifier)
                      .changeThemeColor(color);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.toColor(),
                    shape: BoxShape.circle,
                    border: currentColor == color
                        ? Border.all(
                            color: Theme.of(context).colorScheme.onSurface,
                            width: 3,
                          )
                        : null,
                  ),
                  child: currentColor == color
                      ? Icon(
                          Icons.check,
                          color: _getContrastColor(color.toColor()),
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Color _getContrastColor(Color color) {
    // Calculate luminance to determine if we should use white or black text
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
