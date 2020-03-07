/*
 * This class handles all type of errors that occurs in the app.
 * Particular error will be displayed in to the user through the toast message.
 * Here it handles Network errors, API errors.
 */
import 'package:dio/dio.dart';
import 'package:weatherapp/utils/toast_utils.dart';

displayErrorMsg(DioError error) async {
  if (error.type == DioErrorType.RESPONSE)
    handleAPIError(error);
  else
    showErrorToast(handleError(error));
}

/*
 *This method returns the error other than API error.
 * The error message will be displayed in the toast.
*/
String handleError(DioError error) {
  String errorMsg = "";
  switch (error.type) {
    case DioErrorType.CANCEL:
      errorMsg = "Request to API server was cancelled";
      break;
    case DioErrorType.CONNECT_TIMEOUT:
      errorMsg = 'The server took too long to respond!';
      break;
    case DioErrorType.DEFAULT:
      errorMsg = 'No Internet Connection!';
      break;
    case DioErrorType.RECEIVE_TIMEOUT:
      errorMsg = 'The server took too long to respond!';
      break;
    default:
      errorMsg = 'Something went wrong...Please try again!';
      break;
  }

  return errorMsg;
}

/*
*This method handles the API errors.
* Weather it is a Authentication error or validation error.
 */
handleAPIError(DioError error) async {
  switch (error.response.statusCode) {
    case 401:
      break;
    case 422:
      if (error.response.data['errors'] != null) {
        var errorMsg = error.response.data['errors']['details'][0]['message'];
        showErrorToast(errorMsg);
      } else
        showErrorToast(error.response.data['message']);
      break;
    default:
      showErrorToast(error.response.data['message']);
      break;
  }
}
