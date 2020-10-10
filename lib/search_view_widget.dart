import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchViewWidget extends StatefulWidget {
  SearchViewWidget({this.searchKey}) : super(key: searchKey);

  final Key searchKey;

  @override
  SearchViewWidgetState createState() => SearchViewWidgetState();
}

class SearchViewWidgetState extends State<SearchViewWidget> {
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry _overlayEntry;
  bool _hasFocus = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _hasFocus = true;
        });
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);
      } else {
        setState(() {
          _hasFocus = false;
        });
        this._overlayEntry.remove();
      }
    });
    super.initState();
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: this._layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(width: 0, color: Colors.white),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(_hasFocus ? 0 : 20),
          bottomRight: Radius.circular(_hasFocus ? 0 : 20),
        ),
        border: Border.all(width: 0, color: Colors.white),
        color: Colors.white,
      ),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Container(
          height: 40,
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              hintMaxLines: 1,
              hintText: 'Search',
              fillColor: Colors.white,
            ),
            focusNode: _focusNode,
          ),
        ),
      ),
    );
  }

  void closeSearch() {
    if(_hasFocus){
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}
