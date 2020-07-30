
import 'package:flutter/material.dart';
import 'package:flutter_zhuyi_test/dao/search_dao.dart';
import 'package:flutter_zhuyi_test/model/search_model.dart';
import 'package:flutter_zhuyi_test/pages/home_page.dart';
import 'package:flutter_zhuyi_test/widget/search_bar.dart';

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];
const URL =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=';
class SearchPage extends StatefulWidget{
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  const SearchPage({Key key, this.hideLeft, this.searchUrl = URL, this.keyword, this.hint}) : super(key: key);

  @override
  _SearchPageState createState() =>_SearchPageState();

}

class _SearchPageState extends State<SearchPage>{
  SearchModel searchModel;
  String keyword;

  @override
  void initState() {
    if (widget.keyword != null) {
      _onTextChange(widget.keyword);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(),
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                  flex: 1,
                  child: ListView.builder(
                      itemCount: searchModel?.data?.length??0,
                      itemBuilder: (BuildContext context,int position){
                        return _item(position);
                      },
              ),
          ),
        ],
      ),
    );
  }

  _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x66000000),Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(top:25),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              speakClick: _jumpToSpeak,
              rightButtonClick: (){
                FocusScope.of(context).requestFocus(FocusNode());
              },
              leftButtonClick: (){
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        ),
      ],
    );
  }


  void _jumpToSpeak() {

  }

  void _onTextChange(String text) {
    keyword = text;
    if(text.length == 0){
      setState(() {
        searchModel = null;
      });
      return;
    }
    //考虑到searchUrl会不定期的更新，优先服务端配置返回的searchUrl
    String url = (HomePage.configModel?.searchUrl??widget.searchUrl) + text;
    SearchDao.fetch(url, text).then((SearchModel model){
      //只有当当前输入的内容和服务端返回的内容一致时才渲染
      if(model.keyword == keyword){
        setState(() {
          searchModel = model;
        });
      }
    }).catchError((e){
      print(e);
    });
  }

  Widget _item(int position) {

  }
}