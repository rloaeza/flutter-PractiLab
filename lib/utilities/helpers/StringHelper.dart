

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


}