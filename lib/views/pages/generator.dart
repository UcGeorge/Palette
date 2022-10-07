import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../logic/classes/palette.dart';
import '../../logic/classes/stack.dart';
import '../../logic/cubit/generator_cubit.dart';
import '../../logic/cubit/settings_cubit.dart';
import '../../logic/services/alert_dialogue.dart';
import '../../logic/services/library.dart';
import '../../logic/util/general.dart';
import '../../logic/util/navigation.dart';
import '../../settings/theme.dart';
import '../modals/export_menu.dart';
import '../widgets/bottom_bar_spacer.dart';
import '../widgets/generator_page/color_tile.dart';
import '../widgets/generator_page/undo_redo.dart';
import '../widgets/menu/manu_tile.dart';
import '../widgets/menu_vert.dart';
import '../widgets/more_horiz.dart';
import 'library.dart';
import 'palette.dart';

final _log = Logger('generator_page');

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({super.key});

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  final StackDT<Palette> redoStack = StackDT();
  final StackDT<Palette> undoStack = StackDT();

  void undo() {
    if (undoStack.isNotEmpty) {
      final state = context.read<GeneratorCubit>().state;
      final palette = undoStack.pop;
      redoStack.push(state.palette);
      context.read<GeneratorCubit>().loadPalette(palette);
    }
  }

  void redo() {
    if (redoStack.isNotEmpty) {
      final state = context.read<GeneratorCubit>().state;
      final palette = redoStack.pop;
      undoStack.push(state.palette);
      context.read<GeneratorCubit>().loadPalette(palette);
    }
  }

  void generatePalette(SettingsState settingsState) {
    undoStack.push(context.read<GeneratorCubit>().state.palette);
    _log.info('UNDO STACK: $undoStack');
    redoStack.clear();
    context
        .read<GeneratorCubit>()
        .generatePalette(settingsState.generateMethod);
  }

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
              icon: Icons.remove_red_eye_outlined,
              onTap: () {
                Navigator.of(menuContext).pop();
                cupertinoPageNav(
                  context,
                  child: PaletteView(
                    palette: context.read<GeneratorCubit>().state.palette,
                  ),
                );
              },
              title: 'View palette',
            ),
            const Divider(height: 8),
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
            const Divider(height: 8),
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
                    palette: context.read<GeneratorCubit>().state.palette,
                  ),
                );
              },
              title: 'Export palette',
            ),
            const Divider(height: 8),
            //TODO: Implement settings
            // MenuTile(
            //   settingsState: settingsState,
            //   icon: Icons.settings_outlined,
            //   onTap: doNothing,
            //   title: 'Settings',
            // ),
            // const Divider(height: 8),
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

  Container _buildGeneratorBottomBar(
    SettingsState settingsState,
    BuildContext context,
  ) {
    final bool canUndo = undoStack.isNotEmpty;
    final bool canRedo = redoStack.isNotEmpty;

    return Container(
      height: 52 + screenViewPadding(context).bottom,
      width: screenSize(context).width,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: screenViewPadding(context).bottom,
      ),
      color: theme[settingsState.theme]!.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 52),
          SizedBox(
            width: 72,
            child: UndoRedoIconButtons(
              canUndo: canUndo,
              canRedo: canRedo,
              settingsState: settingsState,
              undo: undo,
              redo: redo,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => generatePalette(settingsState),
            child: Container(
              height: 52,
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: Text(
                  'Generate',
                  style: AppTextTheme.nunito.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            color: Colors.transparent,
            width: 72,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MoreHoriz(
                  settingsState: settingsState,
                  onTap: () => showMenu(settingsState),
                ),
                MenuVert(
                  settingsState: settingsState,
                  onTap: () => cupertinoPageNav(
                    context,
                    child: const LibraryPage(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneratorCubit, GeneratorState>(
      builder: (_, genState) {
        return Material(
          color: genState.palette.first.color,
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (_, settingsState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ReorderableListView(
                    onReorder: (oldIndex, newIndex) => context
                        .read<GeneratorCubit>()
                        .reorderPalette(oldIndex, newIndex),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: genState.palette
                        .map((e) => ColorTileWidget(
                              key: ValueKey(e.color.value),
                              colorTile: e,
                              settingsState: settingsState,
                            ))
                        .toList(),
                  ),
                  _buildGeneratorBottomBar(settingsState, context)
                ],
              );
            },
          ),
        );
      },
    );
  }
}
