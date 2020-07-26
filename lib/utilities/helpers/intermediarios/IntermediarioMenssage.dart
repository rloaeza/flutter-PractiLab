import 'package:practilab/utilities/helpers/MessageInterface.dart';
import 'package:practilab/utilities/helpers/StringHelper.dart';

class IntermediarioMessage{
  Message _message;
  StringHelper _stringHelper = StringHelper();
  void getValidateCredentials(String email,String password)
  {
    if(_stringHelper.isEmail(email))
    {
        if(_stringHelper.emptyPassword(password))
        {
          _message.status("Credenciales válidas!!");
        }
        else
        {
          _message.status("El password es null!!");
        }
    }
    else
    {
      _message.status("El email es inválido!!");
    }
  }

  void setMessageListener(Message message)
  {
    this._message=message;
  }

}