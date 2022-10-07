import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/classes/palette.dart';
import '../../logic/cubit/generator_cubit.dart';
import '../../logic/cubit/settings_cubit.dart';
import '../../logic/services/alert_dialogue.dart';
import '../../logic/services/library.dart';
import '../../logic/util/general.dart';
import '../../settings/theme.dart';
import '../modals/export_menu.dart';
import '../widgets/bottom_bar_spacer.dart';
import '../widgets/menu/manu_tile.dart';
import '../widgets/more_horiz.dart';
import '../widgets/palette_page/text.dart';

class PaletteView extends StatefulWidget {
  const PaletteView({super.key, required this.palette, this.onPop, this.name});

  final Palette palette;
  final String? name;
  final VoidCallback? onPop;

  @override
  State<PaletteView> createState() => _PaletteViewState();
}

class _PaletteViewState extends State<PaletteView> {
  int index = 0;

  void showMenu(SettingsState settingsState) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (modalContext) => _buildMenu(settingsState),
    );
  }

  AppBar _buildAppBar(SettingsState settingsState) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: theme[settingsState.theme]!.white,
      title: Text(
        widget.name ?? 'View palette',
        style: AppTextTheme.nunito.copyWith(
          color: theme[settingsState.theme]!.darkText,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      leading: GestureDetector(
        onTap: Navigator.of(context).pop,
        child: Container(
          color: Colors.transparent,
          child: Icon(
            Icons.close_rounded,
            size: 20,
            color: theme[settingsState.theme]!.darkText,
          ),
        ),
      ),
      actions: [
        MoreHoriz(
          settingsState: settingsState,
          onTap: () => showMenu(settingsState),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Column _buildColorSelector(SettingsState settingsState) {
    return Column(
      children: [
        Container(
          color: theme[settingsState.theme]!.white,
          height: 100 + screenViewPadding(context).bottom,
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: 24 + screenViewPadding(context).bottom,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Row(
              children: widget.palette
                  .map((e) => Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            index = widget.palette.indexOf(e);
                          }),
                          child: Container(
                            color: e.color,
                            child: e == widget.palette[index]
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
        ),
        // const BorromBarSpacer(),
      ],
    );
  }

  Builder _buildMenu(SettingsState settingsState) {
    return Builder(
      builder: (menuContext) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 4),
            MenuTile(
              settingsState: settingsState,
              icon: Icons.auto_fix_high_outlined,
              onTap: () {
                context.read<GeneratorCubit>().loadPalette(widget.palette);
                Navigator.of(menuContext).pop();
                Navigator.of(context).pop();
                widget.onPop?.call();
              },
              title: 'Open in the generator',
            ),
            const Divider(height: 8),
            if (widget.name == null)
              MenuTile(
                settingsState: settingsState,
                icon: Icons.favorite_border,
                onTap: () {
                  Navigator.of(menuContext).pop();
                  LibraryService.addPalette(
                    context,
                    onSuccess: () => AlertService.showAppDialogue(
                      context,
                      text: 'Palette saved!',
                    ),
                  );
                },
                title: 'Save palette',
              ),
            if (widget.name == null) const Divider(height: 8),
            MenuTile(
              hasSubMenu: true,
              settingsState: settingsState,
              icon: Icons.share_outlined,
              onTap: () {
                Navigator.pop(menuContext);
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  builder: (modalContext) => exportMenu(
                    context,
                    settingsState: settingsState,
                    palette: widget.palette,
                  ),
                );
              },
              title: 'Export palette',
            ),
            const Divider(height: 8),
            GestureDetector(
              onTap: Navigator.of(menuContext).pop,
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Cancel',
                    style: AppTextTheme.nunito.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            const BorromBarSpacer(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        return Scaffold(
          appBar: _buildAppBar(settingsState),
          backgroundColor: widget.palette[index].color,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ColorDataText(
                      colorTile: widget.palette[index],
                      colorInfo: ColorInfo.hex,
                      title: 'HEX',
                    ),
                    ColorDataText(
                      colorTile: widget.palette[index],
                      colorInfo: ColorInfo.rgb,
                      title: 'RGB',
                    ),
                    ColorDataText(
                      colorTile: widget.palette[index],
                      colorInfo: ColorInfo.cmyk,
                      title: 'CMYK',
                    ),
                    ColorDataText(
                      colorTile: widget.palette[index],
                      colorInfo: ColorInfo.hsb,
                      title: 'HSB',
                    ),
                    ColorDataText(
                      colorTile: widget.palette[index],
                      colorInfo: ColorInfo.hsl,
                      title: 'HSL',
                    ),
                    ColorDataText(
                      colorTile: widget.palette[index],
                      colorInfo: ColorInfo.lab,
                      title: 'LAB',
                    ),
                  ],
                ),
              ),
              _buildColorSelector(settingsState),
            ],
          ),
        );
      },
    );
  }
}
