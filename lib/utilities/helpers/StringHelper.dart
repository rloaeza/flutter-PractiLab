

class StringHelper
{
  List<String> parts;
  bool isEmail(String email)
  {
    return _hasArroba(email);
  }
  bool _hasArroba(String email)
  {
    if(email.contains("@"))
    {
      parts=email.split("@");
      if(parts.length==2)
      {
        return _server(parts[1]);
      }
    }
    return false;
  }

  bool _server(String server)
  {
    if(server.contains("."))
    {
      parts=server.split(".");
      if(parts.length==2)
      {
        return  parts[0].length>=3 && parts[1].length>=2;
      }
      else if(parts.length==3)
      {
        return parts[0].length>=3 && parts[1].length>=2 && parts[2].length==2;
      }
    }
    return false;
  }

  bool emptyPassword(String password)
  {
    return password.isNotEmpty;
  }

  // funcion que evalua que todos los caracteres sean numeros
  bool numberString(String texto)
  {
    bool status=true;
    for(int i=0;i<texto.length;i++)
    {
      if(texto[0]!="0" && texto[0]!="1" && texto[0]!="2" && texto[0]!="3" && texto[0]!="4" && texto[0]!="5" && texto[0]!="6" && texto[0]!="7" && texto[0]!="8" && texto[0]!="9")
      {
        status=false;
        i=texto.length;
      }

    }
    return status;
  }


}