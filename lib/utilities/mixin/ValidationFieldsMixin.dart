/// usa el mixin cuando quieres compartir un comportamiento a varias clases que
/// no comparten la misma jerarquía de clase,
/// o cuando no tiene sentido implementar tal comportamiento en una
mixin ValidationFieldsMixin
{

  /// Valida password si es mayor o igual a la cantidad de caracteres que metas i.e.:
  /// si [cantMinChars]==6
  /// acepta solo todos aquellos passwords que tengan al menos 6 caracteres
  ///   123456
  ///   qwerty
  ///   holacomoestas
  ///   helloworldthisisavalidpassword
  ///
  /// _isPassword([password],[cantMinChars])
  /// return true o false
  bool _isPassword(String password,int cantMinChars)
  {
    return RegExp(r'^((.{'+cantMinChars.toString()+',}))\$').hasMatch(password);
  }

  /// Valida email i.e.:
  ///   hola.como_mx@servidor.com.mz
  ///   usuario@gmail.com
  /// _isEmail([email])
  /// return true o false
  bool _isEmail(String email)
  {
    return RegExp(r'^(((([a-z0-9]+((\.|_)[a-z0-9]+)*))@((([a-z0-9]{3,})\.[a-z0-9]{2,}){1})((\.[a-z]{2})?)))$').hasMatch(email);
  }
  bool _isNumber(String number,int cantMinChars)
  {
    return RegExp(r'^((\d{'+cantMinChars.toString()+'}))\$').hasMatch(number);
  }
  /// Valida si un campo no esta vacio i.e.:
  /// return  false sino true
  bool isFieldEmpty(String fieldValue)
  {
    return fieldValue.isNotEmpty;
  }
  bool isValidEmail(String val)
  {
    return (isFieldEmpty(val) && _isEmail(val));
  }
  bool isValidPassword(String val,int cantMinChars)
  {
      return (isFieldEmpty(val) && _isPassword(val,cantMinChars));
  }
  bool isNumber(String val,int cantMinChars)
  {
    return (isFieldEmpty(val) && _isNumber(val,cantMinChars));
  }

}
