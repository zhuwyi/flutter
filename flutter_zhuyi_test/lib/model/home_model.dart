
//ConfigModel config	Object	NonNull
//List<CommonModel> bannerList	Array	NonNull
//List<CommonModel> localNavList	Array	NonNull
//GridNavModel gridNav	Object	NonNull
//List<CommonModel> subNavList	Array	NonNull
import 'package:flutter_zhuyi_test/model/common_model.dart';
import 'package:flutter_zhuyi_test/model/config_model.dart';
import 'package:flutter_zhuyi_test/model/grid_nav_model.dart';
import 'package:flutter_zhuyi_test/model/sales_box_model.dart';

class HomeModel{
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel  salesBox;

  HomeModel({this.config, this.bannerList, this.localNavList, this.gridNav,
      this.subNavList, this.salesBox});

  factory HomeModel.fromJson(Map<String,dynamic> json){

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList = localNavListJson.map((i)=> CommonModel.fromJson(i)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList = bannerListJson.map((i)=> CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList = subNavListJson.map((i)=>CommonModel.fromJson(i)).toList();

    return HomeModel(
      config: ConfigModel.fromJson(json['config']),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
      localNavList: localNavList,
      bannerList: bannerList,
      subNavList: subNavList,
    );
  }
}