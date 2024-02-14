import 'package:flutter/cupertino.dart';
import 'package:notes_online_app/shared/components/customButton.dart';

class CustomSearchButton extends StatelessWidget {
  Function onClick;

  CustomSearchButton({
    required this.onClick,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      isSearchButton: true,
        text: "Search note",
        onPressed: (){
          onClick();
        }
    );
  }
}
