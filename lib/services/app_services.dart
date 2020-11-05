import 'package:http/http.dart' as http;
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/check_pin_model.dart';
import 'package:primaxproject/model/checksubscription.dart';
import 'package:primaxproject/model/favorite_status_model.dart';
import 'package:primaxproject/model/models.dart';
import 'package:primaxproject/model/resend_pin_code_model.dart';
import 'dart:convert';

import 'package:primaxproject/model/unsubscribe_model.dart';

/// Localhost url
/// http://192.168.3.51:8080/get/all/movies-paginate?pageNumber=1
/// old url
/// http://159.69.163.162:8081/portals/get
class AppServices {
  static const API = 'http://vod.appcorp.mobi/';
  // hedaaya for subscription with tpay or mondia
  // coming soon will chanage to primax
  /// this url for tpay
  static const apiTpay = 'http://hedaaya.com/api/';
  static const apiMondia = 'http://hedaaya.com/test/mondia/';

  static const headers = {
    'ApiKey': '9A91EE2B3171955C412B58FC6B63F',
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

// http://192.168.3.51:8080/top10/mostWatched

  Future<APIResponse<ShowTopicModel>> getTopTen() async {
    try {
      final response = await http.get(API + 'top10/mostWatched',
          headers: headers);
      if (response.statusCode == 200) {
        print('foundtoptendata');
        final ShowTopicModel results = showTopicModelFromJson(response.body);
        // print(results.results.length);
        return APIResponse<ShowTopicModel>(data: results);
      } else {

        print('notfetchdatatopten');
        return APIResponse<ShowTopicModel>(
            error: true, errorMessage: 'An error occured');
      }
    } catch (error) {
      print(error);
      return APIResponse<ShowTopicModel>(error: true, errorMessage: error);
    }
  }

  Future<APIResponse<ShowTopicModel>> getShowTopicSerivce(
      int pageNumber, String absolutePath) async {
    try {
      final response = await http.get(
          API + absolutePath + "?pageNumber=$pageNumber",
          headers: headers);
      if (response.statusCode == 200) {
        final ShowTopicModel results = showTopicModelFromJson(response.body);
        print(results.results.length);
        return APIResponse<ShowTopicModel>(data: results);
      } else {
        return APIResponse<ShowTopicModel>(
            error: true, errorMessage: 'An error occured');
      }
    } catch (error) {
      return APIResponse<ShowTopicModel>(error: true, errorMessage: error);
    }
  }

  Future<APIResponse<ShowTopicModel>> getLatestMoviesOrSeriesHomeService(
      String absolutePath) async {
    try {
      final response = await http.get(API + absolutePath, headers: headers);
      if (response.statusCode == 200) {
        final ShowTopicModel results = showTopicModelFromJson(response.body);
        print(results.results.length);
        return APIResponse<ShowTopicModel>(data: results);
      } else {
        return APIResponse<ShowTopicModel>(
            error: true, errorMessage: 'An error occured');
      }
    } catch (error) {
      return APIResponse<ShowTopicModel>(error: true, errorMessage: error);
    }
  }

  Future<APIResponse<GenresHomeModel>> getGenresService() async {
    try {
      final response = await http.get(
        API + 'get/LatestByGenres',
        headers: headers,
      );
      if (response.statusCode == 200) {
        final GenresHomeModel results = genresModelFromJson(response.body);
        print('genresModelResultISFound');
        return APIResponse<GenresHomeModel>(data: results);
      } else {
        print('genresNotFound');
        return APIResponse<GenresHomeModel>(
            error: true, errorMessage: 'An error occured');
      }
    } catch (error) {
      print(error);
      print('erroringetGenresServicegetGenresService');
      return APIResponse<GenresHomeModel>(error: true, errorMessage: error);
    }
  }

  Future<APIResponse<ShowTopicModel>> getItemAfterSearch(String keyowrd) async {
    try {
      final response =
          await http.get(API + 'search?keyword=$keyowrd', headers: headers);
      if (response.statusCode == 200) {
        final ShowTopicModel results = showTopicModelFromJson(response.body);
        print('searchIsDisplayed');
        return APIResponse<ShowTopicModel>(data: results);
      } else {
        print('notfetchdataadftersearch');
        return APIResponse<ShowTopicModel>(
            error: true, errorMessage: 'An error occured');
      }
    } catch (error) {
      print(error);
      return APIResponse<ShowTopicModel>(error: true, errorMessage: error);
    }
  }

  //MARK:- add / remove (favorite)
  Future<APIResponse<FavouriteStatusModel>> addOrRemoveTopicFavorite(
      String path, String type, int showId, String userId) async {
    try {
      Map genresBody = {'type': type, 'showId': showId, 'userId': userId};
      var bodyData = json.encode(genresBody);
      final response =
          await http.post(API + path, body: bodyData, headers: headers);
      if (response.statusCode == 200) {
        final FavouriteStatusModel favouriteStatusModel =
            favouriteStatusModelFromJson(response.body);
        print('Item is add Or remove to favorite list');
        return APIResponse<FavouriteStatusModel>(data: favouriteStatusModel);
      } else {
        print('item not add Or remove  in favoriute list');
        return APIResponse<FavouriteStatusModel>(
            error: true, errorMessage: 'An error occured');
      }
    } catch (error) {
      print(error.runtimeType);
      print('erorInMessage');
      return APIResponse<FavouriteStatusModel>(
          error: true, errorMessage: error);
    }
  }

  // MARK:- get all favroites
  //MARK:- operator list tpay
  Future<APIResponse<OperatorSubscriptionModel>>
      getTpayForGetOperatorList() async {
    try {
      var map = new Map<String, dynamic>();
      map['api_key'] = '44b48f2305bf2680';
      final response = await http.post(apiTpay + 'getOperatorsList', body: map);
      if (response.statusCode == 200) {
        final OperatorSubscriptionModel resultOperators =
            operatorSubscriptionModelFromJson(response.body);
        return APIResponse<OperatorSubscriptionModel>(data: resultOperators);
      } else {
        print('Maybe occur error in statuscode${response.statusCode}');
        return APIResponse<OperatorSubscriptionModel>(
            error: true, errorMessage: 'An error occured');
      }
    } catch (error) {
      print(error);
      return APIResponse<OperatorSubscriptionModel>(
          error: true, errorMessage: error);
    }
  }

  //MARK:- operator list mondia media
  Future<APIResponse<OperatorSubscriptionModel>>
      getMondiaMediaForGetOperatorList() async {
    try {
      var map = new Map<String, dynamic>();
      map['api_key'] = '44b48f2305bf2680';
      final response =
          await http.post(apiMondia + 'getOperatorsList', body: map);
      if (response.statusCode == 200) {
        final OperatorSubscriptionModel resultOperators =
            operatorSubscriptionModelFromJson(response.body);
        return APIResponse<OperatorSubscriptionModel>(data: resultOperators);
      } else {
        print('Maybe occur error in statuscode${response.statusCode}');
        return APIResponse<OperatorSubscriptionModel>(
            error: true, errorMessage: 'An error occured');
      }
    } catch (error) {
      print(error);
      return APIResponse<OperatorSubscriptionModel>(
          error: true, errorMessage: error);
    }
  }

  // MARK: subscribe Tpay or mondia
  Future<APIResponse<SubscriptionStatusModel>> getResultAfterSubscription(
      String baseUrl, String path, String msidn, String idOperator) async {
    try {
      var map = new Map<String, dynamic>();
      map['api_key'] = '44b48f2305bf2680';
      map['msisdn'] = msidn;
      map['operator'] = idOperator;
      final response = await http.post(baseUrl + path, body: map);
      print(baseUrl);
      if (response.statusCode == 200) {
        final SubscriptionStatusModel resultSubscribe =
            subscriptionStatusModelFromJson(response.body);
        print(resultSubscribe.statusMessage);
        return APIResponse<SubscriptionStatusModel>(data: resultSubscribe);
      } else {
        print('Maybe occur error in statuscode${response.statusCode}');
        return APIResponse<SubscriptionStatusModel>(
            error: true, errorMessage: 'An error occured');
      }
    } catch (error) {
      print(error);
      return APIResponse<SubscriptionStatusModel>(
          error: true, errorMessage: error);
    }
  }

  // MARK check subscription
  Future<APIResponse<CheckSubscriptionModel>> checkSubscriptionUser(
      String baseUrl, String path, String msidn, String idOperator) async {
    try {
      var map = new Map<String, dynamic>();
      map['api_key'] = '44b48f2305bf2680';
      map['msisdn'] = msidn;
      map['operator'] = idOperator;
      final response = await http.post(baseUrl + path, body: map);
      print(baseUrl);
      if (response.statusCode == 200) {
        final CheckSubscriptionModel userSubscribe =
            checkSubscriptionModelFromJson(response.body);
        print(userSubscribe.statusMessage);
        return APIResponse<CheckSubscriptionModel>(data: userSubscribe);
      } else {
        print('Maybe occur error in statuscode${response.statusCode}');
        return APIResponse<CheckSubscriptionModel>(
            error: true, errorMessage: 'An error occured');
      }
    } catch (error) {
      print(error);
      return APIResponse<CheckSubscriptionModel>(
          error: true, errorMessage: error);
    }
  }

  //MARK unsubscribe user
  Future<APIResponse<UnSubscriptionModel>> unSubscriptionUser(
      String baseUrl, String path, String msidn, String idOperator) async {
    try {
      var map = new Map<String, dynamic>();
      map['api_key'] = '44b48f2305bf2680';
      map['msisdn'] = msidn;
      map['operator'] = idOperator;
      final response = await http.post(baseUrl + path, body: map);
      print(baseUrl);
      if (response.statusCode == 200) {
        final UnSubscriptionModel userSubscribe =
            unSubscriptionModelFromJson(response.body);
        print(userSubscribe.statusMessage);
        return APIResponse<UnSubscriptionModel>(data: userSubscribe);
      } else {
        print('Maybe occur error in statuscode${response.statusCode}');
        return APIResponse<UnSubscriptionModel>(
            error: true, errorMessage: 'An error occured');
      }
    } catch (error) {
      print(error);
      return APIResponse<UnSubscriptionModel>(error: true, errorMessage: error);
    }
  }

//MARK check pin in the case mondia media & tpay
  Future<APIResponse<CheckPinModel>> checkPinCodeInTheCasePinSendToUser(
      String baseUrl,
      String path,
      String msidn,
      String idOperator,
      String pinCode) async {
    try {
      var map = new Map<String, dynamic>();
      map['api_key'] = '44b48f2305bf2680';
      map['msisdn'] = msidn;
      map['operator'] = idOperator;
      map['pinCode'] = pinCode;
      final response = await http.post(baseUrl + path, body: map);
      if (response.statusCode == 200) {
        final CheckPinModel resultPinCode =
            checkPinModelFromJson(response.body);
        print('YesFoundPinCodes');
        print(resultPinCode);
        return APIResponse<CheckPinModel>(data: resultPinCode);
      } else {
        print('Maybe occur error in statuscode${response.statusCode}');
        return APIResponse<CheckPinModel>(
            error: true, errorMessage: 'An error occured');
      }
    } catch (error) {
      print(error.runtimeType);
      print('erorInMessage');
      return APIResponse<CheckPinModel>(error: true, errorMessage: error);
    }
  }

  //Mark: resend pincode
  Future<APIResponse<ResendPinCodeModel>>
      resendPinCodeInTheCasePinNotSendToUser(
          String baseUrl, String path, String msidn, String idOperator) async {
    try {
      var map = new Map<String, dynamic>();
      map['api_key'] = '44b48f2305bf2680';
      map['msisdn'] = msidn;
      map['operator'] = idOperator;
      final response = await http.post(baseUrl + path, body: map);
      if (response.statusCode == 200) {
        final ResendPinCodeModel resultPinCode =
            resendPinCodeModelFromJson(response.body);
        print('YesresendPinCodessuccesssend');
        print(resultPinCode);
        return APIResponse<ResendPinCodeModel>(data: resultPinCode);
      } else {
        print('Maybe occur error in statuscode${response.statusCode}');
        return APIResponse<ResendPinCodeModel>(
            error: true, errorMessage: 'An error occured');
      }
    } catch (error) {
      print(error.runtimeType);
      print('erorInMessage');
      return APIResponse<ResendPinCodeModel>(error: true, errorMessage: error);
    }
  }

  //MARK:- get all favorites user
  Future<APIResponse<ListFavouriteModel>> getFavoriteList(String userId) async {
    try {
      final response = await http.get(API + 'favourite/get-all?userId=$userId',
          headers: headers);
      if (response.statusCode == 200) {
        final ListFavouriteModel listFavouriteModel =
            listFavouriteModelFromJson(response.body);
        print('receive all favorite list success');
        return APIResponse<ListFavouriteModel>(data: listFavouriteModel);
      } else {
        print('Maybe occur error in statuscode${response.statusCode}');
        return APIResponse<ListFavouriteModel>(
            error: true, errorMessage: 'An error occured');
      }
    } catch (error) {
      print(error.runtimeType);
      print('erorInMessage');
      return APIResponse<ListFavouriteModel>(error: true, errorMessage: error);
    }
  }
}
