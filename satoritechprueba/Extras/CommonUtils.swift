//
//  CommonUtils.swift
//  satoritechprueba
//
//  Created by djdenielb on 15/04/23.
//

import Foundation
import UIKit

//Utilizo el observable para que este observando los cambios de las variables que creo aqui
class CommonUtils: ObservableObject {
    
    //Estas variables published son para que esten disponibles en toda la aplicacion, al hacer la intancia de la clase estas variables son observadas y enviadas por medio de combine, cada variable calcula el tamaño de las pantallas dependiendo del dispositivo y retorna un boleano
    @Published var _1_iphone7_8_SE3 = {
        let screenSize: CGRect = UIScreen.main.bounds
        let widthPantalla = screenSize.width
        let heightPantalla = screenSize.height
        var variableRetorno: Bool = false
        if heightPantalla < 668 {
            variableRetorno = true
        }
        return variableRetorno
    }
    @Published var _2_iphone7Or8Plus = {
        let screenSize: CGRect = UIScreen.main.bounds
        let widthPantalla = screenSize.width
        let heightPantalla = screenSize.height
        var variableRetorno: Bool = false
        if heightPantalla > 668 && heightPantalla <= 736 {
            variableRetorno = true
        }
        return variableRetorno
    }
    @Published var _3_iphoneX_XS_11Pro_Mini = {
        let screenSize: CGRect = UIScreen.main.bounds
        let widthPantalla = screenSize.width
        let heightPantalla = screenSize.height
        var variableRetorno: Bool = false
        if heightPantalla > 736 && heightPantalla <= 812 {
            variableRetorno = true
        }
        return variableRetorno
    }
    @Published var _4_iphone12_12Pro_13_13Pro_14 = {
        let screenSize: CGRect = UIScreen.main.bounds
        let widthPantalla = screenSize.width
        let heightPantalla = screenSize.height
        var variableRetorno: Bool = false
        if heightPantalla > 812 && heightPantalla <= 844 {
            variableRetorno = true
        }
        return variableRetorno
    }
    @Published var _5_iphone14_Pro = {
        let screenSize: CGRect = UIScreen.main.bounds
        let widthPantalla = screenSize.width
        let heightPantalla = screenSize.height
        var variableRetorno: Bool = false
        if heightPantalla > 844 && heightPantalla <= 852 {
            variableRetorno = true
        }
        return variableRetorno
    }
    @Published var _6_iphoneXSMax_XR_11ProMAX_11 = {
        let screenSize: CGRect = UIScreen.main.bounds
        let widthPantalla = screenSize.width
        let heightPantalla = screenSize.height
        var variableRetorno: Bool = false
        if heightPantalla > 852 && heightPantalla <= 896 {
            variableRetorno = true
        }
        return variableRetorno
    }
    @Published var _7_iphone12_13_14Max_14Plus = {
        let screenSize: CGRect = UIScreen.main.bounds
        let widthPantalla = screenSize.width
        let heightPantalla = screenSize.height
        var variableRetorno: Bool = false
        if heightPantalla > 896 && heightPantalla <= 932 {
            variableRetorno = true
        }
        return variableRetorno
    }
}
