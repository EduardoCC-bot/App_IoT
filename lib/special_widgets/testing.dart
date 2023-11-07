/*
Flexible(
  flex: 2,
  //dropDownOptions con un FutureBuilder
  child: FutureBuilder<List<String>>(
    future: list, // list es el Future que se obtiene de getLada()
    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {return const CircularProgressIndicator();} 
      else if (snapshot.hasError) {return Text('Error: ${snapshot.error}');} 
      
      else if (snapshot.hasData) {
        return dropDownOptions(
          (String? newValue) {
            setState(() {
              registry.lada = newValue!;
              selectedLada = newValue;
            });
          },
          snapshot.data!, // Datos para el dropdown
          selectedLada ?? snapshot.data!.first, // Valor actual seleccionado o el primero de la lista
          'Lada', // La etiqueta
        );
      } else {return const Text('No hay datos disponibles');}
    },
  ),
),
*/