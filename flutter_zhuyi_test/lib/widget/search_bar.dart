
import 'package:flutter/material.dart';

enum SearchBarType { home, normal, homeLight }

class SearchBar extends StatefulWidget{

  final bool enabled;
  final bool hideLeft;
  final SearchBarType searchBarType;
  final String hint;
  final String defaultText;
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speakClick;
  final void Function() inputBoxClick;
  final ValueChanged<String> onChanged;

  const SearchBar(
      {Key key,
        this.enabled = true,
        this.hideLeft,
        this.searchBarType = SearchBarType.normal,
        this.hint,
        this.defaultText,
        this.leftButtonClick,
        this.rightButtonClick,
        this.speakClick,
        this.inputBoxClick,
        this.onChanged}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();

}

class _SearchBarState extends State<SearchBar>{
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if(widget.defaultText != null){
      setState(() {
        _controller.text = widget.defaultText;
      });
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.searchBarType == SearchBarType.normal? _genNormalSearch()
        : _genHomeSearch();
  }

  _genNormalSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
          Container(
            padding: EdgeInsetsDirectional.fromSTEB(6, 5, 10, 5),
            child: widget?.hideLeft??false?null:Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 26,
            ),
          ),widget.leftButtonClick),
          Expanded(
            flex: 1,
            child: _inputBox()),
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  '搜索',
                  style: TextStyle(color: Colors.blue,fontSize: 17),
                ),
              ),widget.rightButtonClick),
        ],
      ),
    );
  }

  _genHomeSearch() {

  }


  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }

  _inputBox() {

  }
}