class SearchHelper
{
  String praticasContador(int cantidad)
  {
    String practicas="";
    for(int practica=0;practica<cantidad;practica++)
    {
      if(practica==cantidad-1)
      {
        practicas+="Práctica ${practica+1}. ";
      }
      else
      {
        practicas+="Práctica ${practica+1}, ";
      }

    }
    if(practicas=="")
    {
      practicas="No tiene practicas esta clase.";
    }
    return practicas;
  }
  bool evaluarCodigo(String codigo, List<String> materias) {
    bool bandera = false;
    for (String materia in materias)
    {
      if (materia == codigo)
      {
        bandera = true;
        break;
      }
    }
    return bandera;
  }
}