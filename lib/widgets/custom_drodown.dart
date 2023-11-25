import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_export.dart';

class CustomDropdown extends StatefulWidget {
  final String labelText;
  void Function(String?)? onSave;
  void Function(String?)? onChng;
  String? Function(String?)? validator;
  Function(List<dynamic>)? onChanged;
  bool isMultiselect = false;
  String? selectedItem;
  List<dynamic>? multiSelected;
  bool showSearchBox;
  bool? isValidate;
  void Function(List<dynamic>, dynamic)? popupOnItemAdded;
  void Function(List<dynamic>, dynamic)? popupOnItemRemoved;

  List<String> listName;
  CustomDropdown({
    this.onChng,
    this.multiSelected,
    this.popupOnItemRemoved,
    this.popupOnItemAdded,
    this.isValidate = true,
    required this.labelText,
    required this.listName,
    this.selectedItem,
    this.onSave,
    this.validator,
    this.isMultiselect = false,
    this.onChanged,
    this.showSearchBox = false,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? value = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _textLabel(),
        Stack(
          children: [
            Container(
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.01),
                    offset: const Offset(0, 0),
                    spreadRadius: 8)
              ], borderRadius: BorderRadius.circular(15)),
            ),
            widget.isMultiselect
                ? DropdownSearch.multiSelection(
                    mode: Mode.MENU,
                    isFilteredOnline: true,
                    maxHeight: widget.listName.length <= 3 ? 200 : 400,
                    dropdownBuilderSupportsNullItem: true,
                    popupBackgroundColor: Colors.white,
                    showFavoriteItems: true,
                    favoriteItemsAlignment: MainAxisAlignment.start,
                    dropdownSearchTextAlign: TextAlign.start,
                    selectedItems: widget.multiSelected ?? [],
                    popupElevation: 3,
                    showClearButton: true,
                    focusNode: FocusNode(),

                    // for loading indicator
                    loadingBuilder: (context, searchEntry) {
                      return const CircularProgressIndicator();
                    },
                    // for error handling
                    errorBuilder: (context, searchEntry, exception) {
                      return const Center(
                        child: Text("Error"),
                      );
                    },
                    popupOnItemAdded: widget.popupOnItemAdded,

                    popupOnItemRemoved: widget.popupOnItemRemoved,

                    // to check validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select one or more option';
                      }
                      return null;
                    },
                    compareFn: (item, selectedItem) {
                      return item == selectedItem;
                    },
                    filterFn: (item, filter) {
                      return item.toLowerCase().contains(filter.toString());
                    },

                    // while the data is empty

                    emptyBuilder: (context, searchEntry) {
                      return const Center(
                        child: Text("No data found"),
                      );
                    },
                    // dropdown button icon props
                    dropdownButtonProps: const IconButtonProps(
                        icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                    )),

                    // popup barrier color
                    popupBarrierColor: Colors.black.withOpacity(0.2),
                    onPopupDismissed: () {
                      print('Popup dismissed');
                    },
                    // popup shape
                    popupItemDisabled: (item) {
                      return item == 'A' ? true : false;
                    },
                    // favorite items
                    favoriteItemBuilder: (context, item, isSelected) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite_sharp,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              item.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    },
                    favoriteItems: (items) {
                      return items.where((element) => element == 'B').toList();
                    },
                    // popup custom widget
                    popupCustomMultiSelectionWidget: (context, item) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              item.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    },
                    // popup title
                    popupTitle: const Center(
                      child: Text(
                        'Select one or more option',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),

                    popupShape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    searchFieldProps: TextFieldProps(
                      decoration: customInputDecoration(
                          Colors.white, "Search ${widget.labelText}...", false),
                    ),
                    dropdownSearchDecoration: customInputDecoration(
                        Colors.white, "Select ${widget.labelText}", false),

                    showSearchBox: widget.showSearchBox,
                    items: widget.listName,
                    onChanged: widget.onChanged,
                  )
                : DropdownSearch(
                    selectedItem: widget.selectedItem,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    mode: Mode.MENU,
                    emptyBuilder: (context, searchEntry) {
                      return const Center(
                        child: Text("No data found"),
                      );
                    },
                    validator: widget.isValidate!
                        ? widget.validator ??
                            (value) {
                              if (value == null) {
                                return 'Please select ${widget.labelText.toLowerCase()}';
                              }
                              return null;
                            }
                        : null,
                    maxHeight: widget.listName.length <= 3 ? 200 : 300,
                    popupShape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    searchFieldProps: TextFieldProps(
                      decoration: customInputDecoration(
                          Colors.white, "Search ${widget.labelText}", false,
                          labelText: widget.labelText),
                    ),
                    dropdownBuilder: (context, selectedItem) {
                      return Text(selectedItem ?? widget.labelText,
                          style:  TextStyle(
                              color: Colors.black,
                              fontSize: 16.h,
                              fontWeight: FontWeight.w500));
                    },
                    popupItemBuilder: (context, item, isSelected) {
                      return Container(
                        padding:  EdgeInsets.symmetric(
                            vertical: 10.w, horizontal: 30.w),
                        child: Text(item.toString(),
                            style:  TextStyle(
                                color: Colors.black,
                                fontSize: 16.h,
                                fontWeight: FontWeight.w500)),
                      );
                    },
                    dropdownSearchDecoration: customInputDecoration(
                        Colors.white, "Select ${widget.labelText}", false),
                    showClearButton: true,
                    onSaved: widget.onSave,
                    showSearchBox: widget.showSearchBox,
                    items: widget.listName.toList(),
                    onChanged: widget.onChng,
                  ),
          ],
        ),
      ],
    );
  }

  customInputDecoration(Color fillColor, String hintText, bool isPrefixIcon,
      {IconButton? iconButton,
      Widget? prefixIcon,
      Widget? suffixIcon,
      String? counterText,
      bool? offStage,
      bool? isDense,
      TextStyle? counterStyle,
      String? labelText,
      String? errorText}) {
    double radius = 10;
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      labelText: labelText,
      counterStyle: counterStyle,
      counterText: counterText,
      isDense: isDense ?? false,
      errorText: errorText,
      hintText: hintText,
      hintStyle:  TextStyle(
          color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w500),
      errorStyle:  TextStyle(
          color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w500),
      prefixIcon: isPrefixIcon == false
          ? null
          : Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
              child: prefixIcon,
            ),
      suffixIcon: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          bottom: 20.h,
        ),
        child: suffixIcon,
      ),
      filled: true,
      fillColor: fillColor,
      counter: Offstage(
        offstage: offStage ?? true,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: Colors.orange.withOpacity(0.2), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide:
              BorderSide(color: Colors.orange.withOpacity(0.2), width: 1)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: Colors.red.withOpacity(0.8), width: 1)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide:
              BorderSide(color: Colors.orange.withOpacity(0.2), width: 1)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Colors.grey, width: 1)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Colors.grey, width: 1)),
    );
  }

  _textLabel() {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
            padding: EdgeInsets.only(bottom: 5, right: 15),
            child: Text(
              widget.labelText,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            )),
      ],
    );
  }
}
