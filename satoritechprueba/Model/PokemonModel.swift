//
//  PokemonModel.swift
//  satoritechprueba
//
//  Created by Daniel Mateos on 14/04/23.
//

import Foundation
//modelo para parsea el json pokemon
class PokemonModel: Codable {
    var name: String?
    var sprites: PokemonSprite?
    
    init(from dictionary: Dictionary<String,Any>) {
        name = dictionary["name"] as? String
    }
}

class PokemonSprite: Codable {
    var frontDefault: String?
    let frontShiny: String?
    let frontFemale: String?
    let frontShinyFemale: String?
    let backDefault: String?
    let backShiny: String?
    let backFemale: String?
    let backShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontFemale = "front_female"
        case frontShinyFemale = "front_shiny_female"
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case backFemale = "back_female"
        case backShinyFemale = "back_shiny_female"
    }
    
    init(from dictionary: Dictionary<String,Any>) {
        frontDefault = dictionary["frontDefault"] as? String
        frontShiny = dictionary["frontShiny"] as? String
        frontFemale = dictionary["frontFemale"] as? String
        frontShinyFemale = dictionary["frontShinyFemale"] as? String
        backDefault = dictionary["backDefault"] as? String
        backShiny = dictionary["backShiny"] as? String
        backFemale = dictionary["backFemale"] as? String
        backShinyFemale = dictionary["backShinyFemale"] as? String
    }
}
