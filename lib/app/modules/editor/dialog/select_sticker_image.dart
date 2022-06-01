import 'package:flutter/material.dart';

class SelectStickerImageDialog extends StatelessWidget {
  final List<String> emojis;

  const SelectStickerImageDialog({Key? key, this.emojis = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Chọn nhãn"),
      content: emojis.isEmpty
          ? const Text("No images")
          : FractionallySizedBox(
              heightFactor: 0.5,
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    for (final emoji in emojis)
                      InkWell(
                        onTap: () => Navigator.pop(context, emoji),
                        child: FractionallySizedBox(
                          widthFactor: 1 / 4,
                          child: Image.asset(emoji),
                        ),
                      ),
                  ],
                ),
              ),
            ),
      actions: [
        TextButton(
          child: const Text("Hủy"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}