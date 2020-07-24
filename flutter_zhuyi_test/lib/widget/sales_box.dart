
import 'package:flutter/material.dart';
import 'package:flutter_zhuyi_test/model/common_model.dart';
import 'package:flutter_zhuyi_test/model/sales_box_model.dart';
import 'package:flutter_zhuyi_test/util/navigator_util.dart';
import 'package:flutter_zhuyi_test/widget/webview.dart';

class SalesBox extends StatelessWidget
{
  final SalesBoxModel salesBox;

  const SalesBox({Key key, @required this.salesBoxModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    if (salesBox == null) return null;
    List<Widget> items = [];
    items.add(_doubleItem(context, salesBox.bigCard1, salesBox.bigCard2, true, false));
  }

  Widget _doubleItem(BuildContext context, CommonModel leftCard,
      CommonModel rightCard, bool big, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _item(context,leftCard,big,true,last),
        _item(context,rightCard,big,true,last),

      ],
    );

  }

  _item(BuildContext context, CommonModel model, bool big, bool left, bool last) {
    BorderSide borderSide = BorderSide(width: 0.8,color: Color(0xfff2f2f2));
    return GestureDetector(
      onTap: (){
        NavigatorUtil.push(context, WebView(
          url: model.url,
          statusBarColor: model.statusBarColor,
          hideAppBar: model.hideAppBar,
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: left? borderSide:BorderSide.none,
            bottom: last?borderSide:BorderSide.none,
          ),
        ),
        child: Image.network(
          model.icon,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width/2-10,
          height: big?129:80,
        ),
      ),
    );
  }

}