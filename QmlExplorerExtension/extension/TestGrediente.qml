import QtQuick 2.3
import MisComponentes 1.0

Item{
    //Horizontal Gradient
    Gradiente{
        width: 400
        height: 400
        colores: ["red", "blue", "#2f548d"]
        puntos: [0.0 , 0.5, 1.0]
        puntoInicial.x: 0.0
        puntoInicial.y: 0.5
        puntoFinal.x: 1.0
        puntoFinal.y: 0.5
    }

    //Diagonal Gradient
    Gradiente{
        y: 450
        width: 400
        height: 400
        colores: ["red", "blue", "#2f548d"]
        puntos: [0.0 , 0.5, 1.0]
        puntoInicial.x: 0.0
        puntoInicial.y: 0.0
        puntoFinal.x: 1.0
        puntoFinal.y: 1.0
    }
}
