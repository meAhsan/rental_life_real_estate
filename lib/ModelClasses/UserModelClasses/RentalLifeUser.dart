//Model Classes

import 'package:flutter/foundation.dart';

class RentalLifeUser{
  String _userID;

  String _name;
  String _phoneNum;
  int _age;
  String _emailAddress;
  String _userDisplayImageAddress;
  String _bio;
  int _totalAdsPosted;
  int _totalTenantsConnected;
  int _totalOwnersConnected;
  List<String> _adsDocumentsIdList = <String>[];


  List<String> get adsDocumentsIdList => _adsDocumentsIdList;

  set adsDocumentsIdList(List<String> value) {
    _adsDocumentsIdList = value;
  }

  void addAdDocumentIdToList(String id){

    _adsDocumentsIdList.add(id);
  }

  List<String> get adsDocumentIdList{
    return _adsDocumentsIdList;
  }

  void incrementTotalAdsCounter(){
    _totalAdsPosted++;
  }

  RentalLifeUser({@required String userID,String name, int age, String emailAddress, String phoneNum,
    String userDisplayImageAddress, int totalAdsPosted, String bio, int totalTenantsConnected, int totalOwnersConnected,  List<String> adsDocumentsIdList}){
    this._name = name;
    this._age = age;
    this._userID = userID;
    this._emailAddress = emailAddress;
    this._totalAdsPosted = totalAdsPosted ?? 0;
    this._userDisplayImageAddress =userDisplayImageAddress ?? "https://lh3.googleusercontent.com/ogw/ADGmqu_y5fygpa9lyMo25tkCPurKjT0K579xX5UCogHaBw=s83-c-mo";
    this._phoneNum = phoneNum;
    this._bio = bio;
    this.totalTenantsConnected = totalTenantsConnected ?? 0;
    this.totalOwnersConnected = totalOwnersConnected ?? 0;
    this._adsDocumentsIdList =  adsDocumentsIdList ?? <String>[];
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  void incrementTotalAdscount(){
    totalAdsPosted++;
  }

  int get totalAdsPosted => _totalAdsPosted;

  set totalAdsPosted(int value) {
    _totalAdsPosted = value;
  }

  String get emailAddress => _emailAddress;

  set emailAddress(String value) {
    _emailAddress = value;
  }


  String get phoneNum => _phoneNum;

  set phoneNum(String value) {
    _phoneNum = value;
  }

  String get userDisplayImageAddress => _userDisplayImageAddress;

  set userDisplayImageAddress(String value) {
    _userDisplayImageAddress = value;
  }

  String get uid => _userID;

  set uid(String value) {
    _userID = value;
  }

  String get bio => _bio;

  set bio(String value) {
    _bio = value;
  }

  int get totalOwnersConnected => _totalOwnersConnected;

  set totalOwnersConnected(int value) {
    _totalOwnersConnected = value;
  }

  int get totalTenantsConnected => _totalTenantsConnected;

  set totalTenantsConnected(int value) {
    _totalTenantsConnected = value;
  }

  @override
  String toString() {
    return 'RentalLifeUser{_userID: $_userID, _name: $_name, _phoneNum: $_phoneNum, _age: $_age, _emailAddress: $_emailAddress, _userDisplayImageAddress: $_userDisplayImageAddress, _bio: $_bio, _totalAdsPosted: $_totalAdsPosted, _totalTenantsConnected: $_totalTenantsConnected, _totalOwnersConnected: $_totalOwnersConnected, _adsDocumentsIdList: $_adsDocumentsIdList}';
  }
}