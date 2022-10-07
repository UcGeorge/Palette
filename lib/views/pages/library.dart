import 'package:coloors/views/modals/export_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/classes/library_palette.dart';
import '../../logic/cubit/generator_cubit.dart';
import '../../logic/cubit/library_cubit.dart';
import '../../logic/cubit/settings_cubit.dart';
import '../../logic/services/library.dart';
import '../../logic/util/general.dart';
import '../../logic/util/navigation.dart';
import '../../settings/theme.dart';
import '../widgets/bottom_bar_spacer.dart';
import '../widgets/library_page/library_palette_strip.dart';
import '../widgets/menu/manu_tile.dart';
import 'palette.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  late List<LibraryPalette> palette;

  @override
  void initState() {
    super.initState();
    palette = context.read<LibraryCubit>().state.library;
  }

  void showMenu(
    SettingsState settingsState,
    LibraryPalette libraryPalette,
  ) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (modalContext) => _buildMenu(settingsState, libraryPalette),
    );
  }

  Builder _buildMenu(
    SettingsState settingsState,
    LibraryPalette libraryPalette,
  ) {
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
                context
                    .read<GeneratorCubit>()
                    .loadPalette(libraryPalette.palette);
                Navigator.of(menuContext).pop();
                Navigator.of(context).pop();
              },
              title: 'Open in the generator',
            ),
            const Divider(height: 8),
            MenuTile(
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
                    palette: libraryPalette.palette,
                  ),
                );
              },
              title: 'Export palette',
              hasSubMenu: true,
            ),
            const Divider(height: 8),
            MenuTile(
              settingsState: settingsState,
              icon: Icons.copy_rounded,
              onTap: () {
                Navigator.pop(menuContext);
                LibraryService.addPalette(
                  context,
                  libraryPalette: libraryPalette,
                );
              },
              title: 'Duplicate palette',
            ),
            const Divider(height: 8),
            MenuTile(
              settingsState: settingsState,
              icon: Icons.edit_outlined,
              onTap: () {
                Navigator.pop(menuContext);
                LibraryService.updatePalette(
                  context,
                  libraryPalette: libraryPalette,
                );
              },
              title: 'Edit palette',
            ),
            const Divider(height: 8),
            MenuTile(
              settingsState: settingsState,
              icon: Icons.delete_outline_rounded,
              onTap: () {
                context.read<LibraryCubit>().removeFromLibrary(libraryPalette);
                Navigator.pop(menuContext);
              },
              title: 'Delete palette',
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

  AppBar _buildAppBar(context, SettingsState settingsState) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: theme[settingsState.theme]!.white,
      title: Text(
        'Library',
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
            Icons.chevron_left_rounded,
            size: 20,
            color: theme[settingsState.theme]!.darkText,
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size(screenSize(context).width, 1),
        child: const Divider(height: 0),
      ),
      actions: [
        GestureDetector(
          onTap: () => LibraryService.addPalette(context),
          child: Container(
            color: Colors.transparent,
            height: 36,
            width: 36,
            child: Center(
              child: Icon(
                Icons.add_rounded,
                size: 20,
                color: theme[settingsState.theme]!.darkText,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Expanded _buildPaletteList(SettingsState settingsState) {
    return Expanded(
      child: ListView.builder(
        itemCount: palette.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) => LibraryPaletteStrip(
          libraryPalette: palette[index],
          settingsState: settingsState,
          onTap: () => cupertinoPageNav(
            context,
            child: PaletteView(
              name: palette[index].name,
              palette: palette[index].palette,
              onPop: Navigator.of(context).pop,
            ),
          ),
          onMenuTap: () => showMenu(settingsState, palette[index]),
        ),
      ),
    );
  }

  Padding _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        onChanged: (value) {
          final palette_ = context.read<LibraryCubit>().state.library.where(
              (element) =>
                  element.name.toLowerCase().contains(value.toLowerCase()) ||
                  element.tags.any((element) =>
                      element.toLowerCase().contains(value.toLowerCase())));
          setState(() {
            palette = palette_.toList();
          });
        },
        style: AppTextTheme.nunito.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.search),
          constraints: const BoxConstraints(maxHeight: 36),
          fillColor: const Color(0xffF2F2F2),
          filled: true,
          hintText: 'Search name or tag',
          hintStyle: AppTextTheme.nunito.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black.withOpacity(.3),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (_, settingsState) {
        return BlocBuilder<LibraryCubit, LibraryState>(
          builder: (_, state) {
            return Scaffold(
              appBar: _buildAppBar(context, settingsState),
              backgroundColor: theme[settingsState.theme]!.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSearchField(),
                  const Divider(height: 0),
                  _buildPaletteList(settingsState),
                  const BorromBarSpacer(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
