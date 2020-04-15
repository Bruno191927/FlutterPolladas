class PolladaModel {
    int id;
    int numero;
    String nombre;
    String estado;
    int precio;

    PolladaModel({
        this.id,
        this.numero,
        this.nombre,
        this.estado,
        this.precio,
    });

    factory PolladaModel.fromJson(Map<String, dynamic> json) => PolladaModel(
        id: json["id"],
        numero: json["numero"],
        nombre: json["nombre"],
        estado: json["estado"],
        precio: json["precio"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "numero": numero,
        "nombre": nombre,
        "estado": estado,
        "precio": precio,
    };
}