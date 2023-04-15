//
//  PokemonController.swift
//  satoritechprueba
//
//  Created by Daniel Mateos on 14/04/23.
//

import Foundation
import Alamofire
import SwiftUI

class PokemonController: ObservableObject {
    //variables published para llevar los datos a las demas vistas
    @Published var pokemonName: String?
    
    // MARK: - Services
    func networkingPokemon(recibeString: String) {//funcion para el request
        
        //        // MARK: - URL
        let url = "https://pokeapi.co/api/v2/pokemon/\(recibeString)"//Url de pokemon que se concatenara el id del pokemon
        
        let request = AF.request(url, method: .get) //variable alamofire con su constructor qe indica que sera meotodo get

        request.responseJSON(completionHandler: { response in//respuesta con el closure que contiene el parseo y los estados de error
            let statusCode = response.response?.statusCode //estado de error o exito
            print("-> Status Pokemon \(String(describing: statusCode))")
            print("-> URL Pokemon \(url)")
            print("-> Response Pokemon \(String(describing: response.value))")

            if statusCode == 200 {//en caso de que sea un 200
                let defaults = UserDefaults.standard//inicializamos una variable user default
                defaults.set(200, forKey: "statusCode")//asiganos el estado 200
                print("***** Consumo exitoso")
                if let dataDict: Dictionary<String,Any> = (response.value as? Dictionary<String, Any>) {//variable diccionario
                    let objetoParseado: PokemonModel = PokemonModel(from: dataDict)//el objeto lo parseamos con la variable diccionario
                    self.pokemonName = objetoParseado.name //la variable published se llena con el parametro del objeto parseado
                    print("***** PokemonName \(String(describing: self.pokemonName))")
                }
            } else if statusCode == 404 {//en caso de que sea un 400
                let defaults = UserDefaults.standard
                defaults.set(404, forKey: "statusCode")//llenamos usersdefault
            } else if statusCode == 500 {//en caso de que sea un 500
                let defaults = UserDefaults.standard
                defaults.set(500, forKey: "statusCode")//llenamos usersdefault
            }
        })
    }
}
