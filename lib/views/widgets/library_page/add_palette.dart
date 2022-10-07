import 'package:flutter/material.dart';

import '../../../logic/classes/library_palette.dart';
import '../../../logic/classes/palette.dart';
import '../../../logic/util/general.dart';
import '../../../settings/theme.dart';
import '../bottom_bar_spacer.dart';
import 'color_text_field.dart';
import 'text_field.dart';

class AddPalette extends StatefulWidget {
  const AddPalette({
    Key? key,
    required this.palette,
    this.name,
    this.description,
    this.tags,
    this.onSuccess,
  }) : super(key: key);

  final String? description;
  final String? name;
  final VoidCallback? onSuccess;
  final Palette palette;
  final List<String>? tags;

  @override
  State<AddPalette> createState() => _AddPaletteState();
}

class _AddPaletteState extends State<AddPalette> {
  late TextEditingController colorController;
  late TextEditingController descriptionController;
  late TextEditingController nameController;
  late Palette palette;
  int selectedColorTile = 0;
  int selectedTab = 0;
  late TextEditingController tagsController;

  @override
  void initState() {
    super.initState();
    palette = widget.palette;
    colorController = TextEditingController(
      text: "#${widget.palette.first.colorTextHEX.toUpperCase()}",
    );
    nameController = TextEditingController(text: widget.name);
    descriptionController = TextEditingController(text: widget.description);
    tagsController = TextEditingController(text: widget.tags?.join(', '));
  }

  String get name => nameController.value.text.trim();

  String get description => descriptionController.value.text.trim();

  List<String> get tags =>
      tagsController.value.text.split(',').map((e) => e.trim()).toList();

  GestureDetector _buildTabHead(String title, int index) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedTab = index;
      }),
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selectedTab == index ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextTheme.nunito.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildTabBar() {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTabHead('Info', 0),
          _buildTabHead('Colors', 1),
        ],
      ),
    );
  }

  Padding _buildModalAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          Text(
            'Save Palette',
            style: AppTextTheme.nunito.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: nameController.value.text.isNotEmpty
                    ? () {
                        final libraryPalette = LibraryPalette(
                          id: '',
                          name: name,
                          description: description,
                          tags: tags,
                          palette: palette,
                        );
                        Navigator.pop(context, libraryPalette);
                        widget.onSuccess?.call();
                      }
                    : null,
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Save',
                    style: AppTextTheme.nunito.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildInfoForm() {
    return Container(
      color: const Color(0xffF2F2F2),
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SettingsTextField(
              label: 'Name',
              autoFocus: true,
              controller: nameController,
              hintText: 'My new palette',
              onChanged: (value) => setState(() {}),
            ),
            const Divider(height: 0),
            SettingsTextField(
              label: 'Description',
              controller: descriptionController,
              hintText: '',
            ),
            const Divider(height: 0),
            SettingsTextField(
              label: 'Tags',
              controller: tagsController,
              hintText: 'tag1, tag2, tag3',
            ),
          ],
        ),
      ),
    );
  }

  Container _buildColorForm() {
    return Container(
      color: const Color(0xffF2F2F2),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ColorTextField(
                  controller: colorController,
                  colorTile: palette[selectedColorTile],
                  onChanged: (value) {
                    final selection = colorController.selection;
                    setState(() {
                      palette[selectedColorTile] = value;
                    });
                    colorController.selection = selection;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildColorSelector(),
        ],
      ),
    );
  }

  SizedBox _buildColorSelector() {
    return SizedBox(
      height: 48,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: widget.palette
              .map((e) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColorTile = widget.palette.indexOf(e);
                          colorController.text =
                              "#${e.colorTextHEX.toUpperCase()}";
                        });
                        colorController.selection = TextSelection.fromPosition(
                          TextPosition(offset: colorController.text.length),
                        );
                      },
                      child: Container(
                        color: e.color,
                        child: e == widget.palette[selectedColorTile]
                            ? Center(
                                child: CircleAvatar(
                                  radius: 4.5,
                                  backgroundColor: e.foregroundTextColor,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final kbHeight = screenViewInsets(context).bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildModalAppBar(),
        const Divider(height: 0),
        _buildTabBar(),
        selectedTab == 0 ? _buildInfoForm() : _buildColorForm(),
        const Divider(height: 0),
        if (kbHeight > 0) SizedBox(height: kbHeight),
        if (kbHeight == 0) const BorromBarSpacer(),
      ],
    );
  }
}
