import 'package:flutter/material.dart';
import 'package:gto_docs_v2_ad/shared/ui/theme/gerencia_config.dart';

class GradientHeader extends StatelessWidget {
  final GerenciaTheme theme;
  final String userName;

  const GradientHeader({
    super.key,
    required this.theme,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Container(
      padding: EdgeInsets.fromLTRB(24, isTablet ? 32 : 24, 24, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorPrimario, theme.colorSecundario],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(isTablet ? 40 : 32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('¡Hola! 👋',
              style: TextStyle(
                color: Colors.white70,
                fontSize: isTablet ? 20 : 16,
              )),
          Text(
            userName,
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 32 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}