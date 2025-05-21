import 'package:flutter/material.dart';
import 'app_colours.dart';

@immutable
class FinancialThemeExtension extends ThemeExtension<FinancialThemeExtension> {
  const FinancialThemeExtension({
    required this.background,
    required this.unselectedIcon,
    required this.selectedIcon,
    required this.income,
    required this.expense,
    required this.savings,
    required this.investment,
  });

  final Color background,
      unselectedIcon,
      selectedIcon,
      income,
      expense,
      savings,
      investment;

  @override
  FinancialThemeExtension copyWith({
    Color? background,
    Color? unselectedIcon,
    Color? selectedIcon,
    Color? income,
    Color? expense,
    Color? savings,
    Color? investment,
  }) {
    return FinancialThemeExtension(
      background: background ?? this.background,
      unselectedIcon: unselectedIcon ?? this.unselectedIcon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      savings: savings ?? this.savings,
      investment: investment ?? this.investment,
    );
  }

  @override
  FinancialThemeExtension lerp(
    ThemeExtension<FinancialThemeExtension>? other,
    double t,
  ) {
    if (other is! FinancialThemeExtension) {
      return this;
    }
    return FinancialThemeExtension(
      background: Color.lerp(background, other.background, t)!,
      unselectedIcon: Color.lerp(unselectedIcon, other.unselectedIcon, t)!,
      selectedIcon: Color.lerp(selectedIcon, other.selectedIcon, t)!,
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      savings: Color.lerp(savings, other.savings, t)!,
      investment: Color.lerp(investment, other.investment, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  static const _seedColour = Color(0xFF0A7E8C);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: _seedColour,
    brightness: Brightness.light,
    extensions: const <ThemeExtension<dynamic>>[
      FinancialThemeExtension(
        background: AppColors.backgroundLight,
        unselectedIcon: AppColors.unselectedIcon,
        selectedIcon: AppColors.selectedIconLight,
        income: AppColors.income,
        expense: AppColors.expense,
        savings: AppColors.savings,
        investment: AppColors.investment,
      ),
    ],
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: _seedColour,
    brightness: Brightness.dark,
    extensions: const <ThemeExtension<dynamic>>[
      FinancialThemeExtension(
        background: AppColors.backgroundDark,
        unselectedIcon: AppColors.unselectedIcon,
        selectedIcon: AppColors.selectedIconDark,
        income: AppColors.income,
        expense: AppColors.expense,
        savings: AppColors.savings,
        investment: AppColors.investment,
      ),
    ],
  );
}
