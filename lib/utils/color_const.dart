import 'package:flutter/material.dart';

class ColorConst {
  static Color MARK_ALL_COLOR = colorFromHex('#164194');
  static Color BORDER_COLOR = colorFromHex('#E8E8E8');
  static Color SMALL_ROUND_COLOR = colorFromHex('#D9D9D9');
  static Color BLUE_COLOR = colorFromHex('#01256C');
  static Color DELETE_BG_COLOR = colorFromHex('#FEF2F0');
  static Color PENDING_COLOR = colorFromHex('#FFB728');
  static Color BG_COLOR = colorFromHex('#F7F7F7');
  static Color APPROVE_COLOR = colorFromHex('#9FD89A');
  static Color REJECT_COLOR = colorFromHex('#E33849');
  static Color APP_LOGO_COLOR = colorFromHex('#FF275A');
  static Color GREY_BLACK_COLOR = colorFromHex('#4D4D4F');
  static Color BUTTON_DISABLE_TEXT_COLOR = colorFromHex('#676769');
  static Color GREY_WHITE_COLOR = colorFromHex('#EDEDED');
  static Color CANCEL_BTN_TEXT_COLOR = colorFromHex('#8D8D8F');
  static Color BLACK_LIGHT_COLOR = colorFromHex('#151414');
  static Color PHONE_DIVIDER_LIGHT_COLOR = colorFromHex('#E4E4E4');
  static Color DIVIDER_COLOR = colorFromHex('#DBDBDB');
  static Color GREY_COLOR = colorFromHex('#747476');
  static Color BLUE_T_C_COLOR = colorFromHex('#1E88E5');
  static const Color WHITE_COLOR = Colors.white;
  static const Color BLACK_COLOR = Colors.black;
  static const Color LIGHT_BLACK_COLOR = Colors.black45;
  static const Color BLUE_GREY_COLOR = Colors.blueGrey;

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
