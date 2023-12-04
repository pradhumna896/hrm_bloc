import '../core/app_export.dart';

calenderTheme(child, context) {
  return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
              primary: Colors.orange,
              onPrimary: Colors.white,
              onSurface: Colors.grey),
          dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  textStyle: const TextStyle(fontFamily: "Poppins")))),
      child: child!);
}