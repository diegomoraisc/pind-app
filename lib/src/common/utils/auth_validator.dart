class AuthValidator {
  AuthValidator._();

  static String? validateName(String? value) {
    final conditionRegex = RegExp(r"\b([A-ZÀ-ÿ][-,a-z. ']+[ ]*)+");
    if (value != null && value.isEmpty) {
      return "O campo não pode ser vazio";
    }
    if (value != null && !conditionRegex.hasMatch(value)) {
      return "Nome inválido. Por favor, insira um nome válido";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final conditionRegex = RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    if (value != null && value.isEmpty) {
      return "O campo não pode ser vazio";
    }
    if (value != null && !conditionRegex.hasMatch(value)) {
      return "E-mail inválido. Por favor, insira um e-mail válido";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final conditionRegex = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");
    if (value != null && value.isEmpty) {
      return "O campo não pode ser vazio";
    }
    if (value != null && !conditionRegex.hasMatch(value)) {
      return "Senha inválida. Por favor, insira uma senha válida";
    }
    return null;
  }
  static String? validateConfirmPassword(String? firstValue, String? secondValue) {
    if (firstValue != null && firstValue.isEmpty) {
      return "O campo não pode ser vazio";
    }
    if (firstValue != secondValue) {
      return "Senhas inválidas. As senhas precisam ser iguais";
    }
    return null;
  }
}
