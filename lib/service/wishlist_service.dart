
import 'package:http/http.dart' as http;
import 'package:present_picker/model/wishlist_model.dart';
import 'package:present_picker/service/local_db_service.dart';
import 'package:present_picker/utils/Utils.dart';


class WishListService {
  Future<String> postWishList(
      {required WishList wishList, required bool isFile}) async {
    String userToken = await LocalDbService.retrieveToken;
    String url = Utils.wishlistURL;
    Map<String, String> headers = {'Authorization': userToken};

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll(
          isFile ? wishList.toJsonWithFile() : wishList.toJsonWithThumbnail());
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        return 'success';
      } else {
        throw Exception("Failed");
      }

    } catch (e) {

      rethrow;
    }
  }


}
