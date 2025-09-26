import 'package:flutter/material.dart';
import 'package:flutter_figma_trial/manager/breaks_page.dart';
import 'package:flutter_figma_trial/manager/holidays_page.dart';
import 'package:flutter_figma_trial/manager/shifts_page.dart';

// Domain Models
class SettingsMenuItem {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final bool hasDropdown;
  final String? subtitle;
  final List<String>? options; // 👈 add this for expansion items

  const SettingsMenuItem({
    required this.title,
    required this.icon,
    this.onTap,
    this.hasDropdown = false,
    this.subtitle,
    this.options,
  });
}

// UI Constants
class SettingsConstants {
  static const double itemHeight = 56.0;
  static const double iconSize = 24.0;
  static const double horizontalPadding = 16.0;
  static const double verticalSpacing = 8.0;
  static const double borderRadius = 8.0;
}

// Theme
class SettingsTheme {
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color dividerColor = Color(0xFFE0E0E0);
}

// Settings Repository Interface
abstract class SettingsRepository {
  List<SettingsMenuItem> getMainMenuItems(BuildContext context);
  List<SettingsMenuItem> getHelpMenuItems();
}

// Settings Repository Implementation
class SettingsRepositoryImpl implements SettingsRepository {
  @override
  List<SettingsMenuItem> getMainMenuItems(BuildContext context) {
    return [
      SettingsMenuItem(
        title: 'Face ID qurilmalari',
        icon: Icons.face,
        onTap: () => _handleFaceIdTap(),
      ),
      SettingsMenuItem(
        title: 'Smenalar',
        icon: Icons.palette_outlined,
        onTap: () => _handleThemesTap(context),
      ),
      SettingsMenuItem(
        title: 'Dam olish kunlari',
        icon: Icons.calendar_today_outlined,
        onTap: () => _handleHolidaysTap(context),
      ),
      SettingsMenuItem(
        title: 'Tanaffuslar',
        icon: Icons.schedule_outlined,
        onTap: () => _handleBreaksTap(context),
      ),
      SettingsMenuItem(
        title: "O'zbekcha", // current selected one
        icon: Icons.language_outlined,
        options: ["O‘zbekcha", "Русский", "English"],
      ),
    ];
  }

  @override
  List<SettingsMenuItem> getHelpMenuItems() {
    return [
      SettingsMenuItem(
        title: 'Yordam',
        icon: Icons.help_outline,
        onTap: () => _handleHelpTap(),
      ),
    ];
  }

  void _handleFaceIdTap() {
    // TODO: Navigate to Face ID settings
  }

  void _handleThemesTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShiftsPage()),
    );
  }

  void _handleHolidaysTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HolidaysPage()),
    );
  }

  void _handleBreaksTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BreaksPage()),
    );
  }

  void _handleLanguageTap() {
    // TODO: Show language picker
  }

  void _handleHelpTap() {
    // TODO: Navigate to help
  }
}

// Settings Use Case
class SettingsUseCase {
  final SettingsRepository _repository;

  SettingsUseCase(this._repository);

  List<SettingsMenuItem> getMainMenuItems(BuildContext context) =>
      _repository.getMainMenuItems(context);
  List<SettingsMenuItem> getHelpMenuItems() => _repository.getHelpMenuItems();
}

// Settings State Management
class SettingsState {
  final List<SettingsMenuItem> mainMenuItems;
  final List<SettingsMenuItem> helpMenuItems;
  final bool isLoading;

  const SettingsState({
    this.mainMenuItems = const [],
    this.helpMenuItems = const [],
    this.isLoading = false,
  });

  SettingsState copyWith({
    List<SettingsMenuItem>? mainMenuItems,
    List<SettingsMenuItem>? helpMenuItems,
    bool? isLoading,
  }) {
    return SettingsState(
      mainMenuItems: mainMenuItems ?? this.mainMenuItems,
      helpMenuItems: helpMenuItems ?? this.helpMenuItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// Settings Controller
class SettingsController extends ChangeNotifier {
  final SettingsUseCase _useCase;
  SettingsState _state = const SettingsState();

  SettingsController(this._useCase);

  SettingsState get state => _state;

  void initializeSettings(BuildContext context) {
    _updateState(_state.copyWith(isLoading: true));

    final mainItems = _useCase.getMainMenuItems(context);
    final helpItems = _useCase.getHelpMenuItems();

    _updateState(
      _state.copyWith(
        mainMenuItems: mainItems,
        helpMenuItems: helpItems,
        isLoading: false,
      ),
    );
  }

  void _updateState(SettingsState newState) {
    _state = newState;
    notifyListeners();
  }
}

// UI Components
class SettingsMenuItemW extends StatelessWidget {
  final SettingsMenuItem item;

  const SettingsMenuItemW({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    if (item.options != null && item.options!.isNotEmpty) {
      // 👉 ExpansionTile for language
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: SettingsConstants.horizontalPadding,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: SettingsTheme.cardColor,
          borderRadius: BorderRadius.circular(SettingsConstants.borderRadius),
        ),
        child: ExpansionTile(
          leading: Icon(
            item.icon,
            size: SettingsConstants.iconSize,
            color: SettingsTheme.textSecondary,
          ),
          title: Text(
            item.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: SettingsTheme.textPrimary,
            ),
          ),
          children: item.options!
              .map(
                (lang) => ListTile(
                  title: Text(lang),
                  onTap: () {
                    // TODO: handle language change
                  },
                ),
              )
              .toList(),
        ),
      );
    }

    // 👉 Normal item (not expandable)
    return Container(
      height: SettingsConstants.itemHeight,
      margin: const EdgeInsets.symmetric(
        horizontal: SettingsConstants.horizontalPadding,
        vertical: 2,
      ),
      child: MaterialButton(
        onPressed: item.onTap,
        color: SettingsTheme.cardColor,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: SettingsConstants.horizontalPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SettingsConstants.borderRadius),
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              size: SettingsConstants.iconSize,
              color: SettingsTheme.textSecondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: SettingsTheme.textPrimary,
                ),
              ),
            ),
            if (item.hasDropdown)
              const Icon(
                Icons.keyboard_arrow_down,
                color: SettingsTheme.textSecondary,
              ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SettingsConstants.horizontalPadding,
        20,
        SettingsConstants.horizontalPadding,
        8,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: SettingsTheme.textSecondary,
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const LogoutButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 162,
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.red,
        textColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SettingsConstants.borderRadius),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, size: 16),
            SizedBox(width: 4),
            Text(
              'Akkauntdan chiqish',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// Main Settings Page
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsController _controller;

  @override
  void initState() {
    super.initState();
    final repository = SettingsRepositoryImpl();
    final useCase = SettingsUseCase(repository);
    _controller = SettingsController(useCase);
    _controller.initializeSettings(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Sozlamalar paneli',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: SettingsTheme.textPrimary,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: SettingsTheme.primaryColor,
              child: Text(
                'T',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (_controller.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown Header
                Container(
                  margin: const EdgeInsets.all(
                    SettingsConstants.horizontalPadding,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: SettingsTheme.cardColor,
                    borderRadius: BorderRadius.circular(
                      SettingsConstants.borderRadius,
                    ),
                    border: Border.all(color: SettingsTheme.dividerColor),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TimePay Humo Arena Filiali',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: SettingsTheme.textPrimary,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: SettingsTheme.textSecondary,
                      ),
                    ],
                  ),
                ),

                // Main Settings Section
                const SectionHeader(title: 'Sozlamalar & yordam'),
                ..._controller.state.mainMenuItems.map(
                  (item) => SettingsMenuItemW(item: item),
                ),

                const SizedBox(height: 20),

                // Help Section
                ..._controller.state.helpMenuItems.map(
                  (item) => SettingsMenuItemW(item: item),
                ),

                const SizedBox(height: 40),

                // Logout Button
                Center(child: LogoutButton(onPressed: _handleLogout)),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chiqish'),
        content: const Text('Akkauntdan chiqishni xohlaysizmi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Bekor qilish'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement logout logic
            },
            child: const Text('Chiqish', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
