
import '../core/app_export.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    required this.value,
    required this.onChanged,
    required this.title,
    super.key,
  });

  final bool value;
  final Function(bool?) onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          checkColor: Colors.white,
          activeColor: Colors.orange,
          fillColor: MaterialStateProperty.all(Colors.orange),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          
          ),
        ),
      ],
    );
  }
}