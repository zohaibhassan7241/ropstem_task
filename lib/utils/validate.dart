enum ValidateType { normal, email, make, model, registration, color }

class UtilValidator {
  static const String errorEmpty = "Input is not empty";
  static const String errorRange = "Input not valid range";
  static const String errorEmail = "Input not valid email";
  static const String errorPassword = "Input not valid password";
  static const String errorMake = "Please enter the make of the car";
  static const String errorModel = "Please enter the model of the car";
  static const String errorRegis = "Please enter the registration of the car";
  static const String errorColor = "Please enter the color of the car";

  static String? validate(
    String data, {
    ValidateType? type = ValidateType.normal,
    int? min,
    int? max,
    bool allowEmpty = false,
    String? match,
  }) {
    ///Empty
    if (!allowEmpty && data.isEmpty) {
      switch (type) {

        ///Make
        case ValidateType.make:
          if (data.isEmpty) {
            return errorMake;
          }
          break;

        ///Model
        case ValidateType.model:
          if (data.isEmpty) {
            return errorModel;
          }
          break;

        ///Registration
        case ValidateType.registration:
          if (data.isEmpty) {
            return errorRegis;
          }
          break;

        ///Color
        case ValidateType.color:
          if (data.isEmpty) {
            return errorColor;
          }
          break;
        default:
      }
      return errorEmpty;
    }
    if (data.isEmpty) return null;

    switch (type) {

      ///Email pattern
      case ValidateType.email:
        final emailRegex = RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
        );
        if (!emailRegex.hasMatch(data)) {
          return errorEmail;
        }
        break;

      ///Make
      case ValidateType.make:
        if (data.isEmpty) {
          return errorMake;
        }
        break;

      ///Model
      case ValidateType.model:
        if (data.isEmpty) {
          return errorModel;
        }
        break;

      ///Registration
      case ValidateType.registration:
        if (data.isEmpty) {
          return errorRegis;
        }
        break;

      ///Color
      case ValidateType.color:
        if (data.isEmpty) {
          return errorColor;
        }
        break;
      default:
    }
    return null;
  }

  ///Singleton factory
  static final UtilValidator _instance = UtilValidator._internal();

  factory UtilValidator() {
    return _instance;
  }

  UtilValidator._internal();
}
