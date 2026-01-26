import 'package:flutter/material.dart';

import '../theme/gerencia_config.dart';

class GerenciaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GerenciaTheme theme;
  final String title;
  final List<Widget>? actions;
  final bool showBack;

  const GerenciaAppBar({
    super.key,
    required this.theme,
    required this.title,
    this.actions,
    this.showBack = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final radius = isTablet ? 24.0 : 20.0;

    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.2,
    );

    return AppBar(
      backgroundColor: theme.colorPrimario,
      elevation: 4,
      scrolledUnderElevation: 0,
      centerTitle: true,
      foregroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: Text(title, style: titleStyle),
      actions: actions,
      shadowColor: theme.colorPrimario.withAlpha(60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)),
      ),
    );
  }
}
