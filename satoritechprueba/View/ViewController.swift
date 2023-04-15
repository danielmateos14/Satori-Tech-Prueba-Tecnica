//
//  ViewController.swift
//  satoritechprueba
//
//  Created by Daniel Mateos on 14/04/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    //MARK: ******* Instancias ******
    //Instancia controller
    @ObservedObject var pokemonController = PokemonController() //instancia del controlador
    @ObservedObject var commonUtils = CommonUtils() //Instancia del common utils
    
    //MARK: ******* Outlets ******
    //elementos graficos
    @IBOutlet weak var imageViewPokemon: UIImageView!
    @IBOutlet weak var labelNombrePokemon: UILabel!
    @IBOutlet weak var buttonObtenerOutlet: UIButton!
    @IBOutlet weak var imageView2Pokemon: UIImageView!
    @IBOutlet weak var imageView3Pokemon: UIImageView!
    
    //MARK: ******* Constriants ******
    //Constraints para manejar el modo responsivo
    @IBOutlet weak var constraintHeightMainImage: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightStackImages: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modoResponsivo() //Funcion para modificar los constraints dependiendo del tamaño de pantalla
        cada30Segundos() //funcion que se ejecutara cada 30 segundos a partir del incicio del ciclo de vida del view controller
        personalizarImageView(recibeImageView: imageViewPokemon, recibeIV2: imageView2Pokemon, recibeIV3: imageView3Pokemon) //funcion que personaliza las image view
        buttonObtenerOutlet.layer.cornerRadius = 15 //redondear el boton
    }
    
    //MARK: ******* Actions ******
    @IBAction func buttonCargarPokemon(_ sender: Any) {
        performSegue(withIdentifier: "segueLoader", sender: nil) //Navegacion a la vista del loader
        let numAleatorio = aleatorio()//Primero generamos un numero aleatorio
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){ //meto un dispatch para que la url no falle al no tener el id al final
            self.pokemonController.networkingPokemon(recibeString: numAleatorio)//mando a llamar al request que obtendra el json
            let statusCode = UserDefaults.standard.integer(forKey: "statusCode")//Asigno el estado de la respuesta del request
            if statusCode == 404 {//verifico si es un 404 la respuesta
                //Muestro una Alerta
                self.alerta(titulo: "Error Pokemon", mensaje: "Ha ocurrido un error al obtener los Pokemons, por favor vuelve a intentarlo")
            } else if statusCode == 500 {//verifico si es un 500 la respuesta
                //Muestro Alerta
                self.alerta(titulo: "Error Servidor", mensaje: "Ha ocurrido un error en el servidor, intenta mas tarde")
            } else {//En caso de que sea correcto
                self.crearImagenDesdeUrl(recibeString: numAleatorio)//llamo a la funcion que parsea la imagen
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){//pongo un dispatch para darle tiempo a la conversion de la imagen
                    self.labelNombrePokemon.text = "\(self.pokemonController.pokemonName ?? "Pokemon")"//asigno el nombre parseado del pokemon
                    self.labelNombrePokemon.font = self.labelNombrePokemon.font.withSize(50)//cambio el tamaño de la label
                }
            }
        }
    }
    
    //MARK: ******* Funciones ******
    
    func crearImagenDesdeUrl(recibeString: String){//funcion que conviete la imagen desde una url
        //una guard let para crear la imagen y le concateno el id
        guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(recibeString).png" ) else { return }
        guard let url2 = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/\(recibeString).png" ) else { return }
        guard let url3 = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/\(recibeString).png" ) else { return }
        tarea(imageView: imageViewPokemon, recibeURL: url)//llamada la funcion que ejecuta la tarea de conversion de la url a imagen
        tarea(imageView: imageView2Pokemon, recibeURL: url2)
        tarea(imageView: imageView3Pokemon, recibeURL: url3)
    }
    
    func tarea(imageView: UIImageView, recibeURL: URL){//funcion tarea que convierte una url en una imagen, recibe la url y la imageview
        let task = URLSession.shared.dataTask(with: recibeURL) { data, response, error in
            if error != nil {
                // SI hay error no truena, se puede poner un mensaje al usuario
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                // SI hay un error en la conversion, se asigna una imagen por default
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                    imageView.image = UIImage(named: "imgnf")
                }
                
                return
            }
            // la imagen se ha cargado correctamente
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                // Se pone en un dispacth para manejar de forma correcta el modo asincrono y se asigna la imagen convertida a un imageview
                imageView.image = image
            }
        }
        task.resume()//se inicia la tarea
    }

    func cada30Segundos(){//funcion que se ejecuta cada 30 segundos
        Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { Timer in//Funcion del timer para repetir cada 30 segundos una accion
            self.performSegue(withIdentifier: "segueLoader", sender: nil)//navega al loader cada 30 segundos
            self.pokemonController.networkingPokemon(recibeString: self.aleatorio())//llama al request
            let statusCode = UserDefaults.standard.integer(forKey: "statusCode")//asigna el status code del usersdefault a la variable
            if statusCode == 404 {//verifico si es un 404 la respuesta
                //Muestro una alerta
                self.alerta(titulo: "Error Pokemon", mensaje: "Ha ocurrido un error al obtener los Pokemons, por favor vuelve a intentarlo")
            } else if statusCode == 500 {//verifico si es un 500 la respuesta
                //Muestro una alerta
                self.alerta(titulo: "Error Servidor", mensaje: "Ha ocurrido un error en el servidor, intenta mas tarde")
            } else {//En caso de que sea correcto
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.crearImagenDesdeUrl(recibeString: self.aleatorio())
                    self.labelNombrePokemon.text = self.pokemonController.pokemonName
                    self.labelNombrePokemon.font = self.labelNombrePokemon.font.withSize(50)//cambio el tamaño de la label
                }
            }
        }
    }
    
    func aleatorio() -> String {//funcion para crear un numero aleatorio, si se requiere extender el rango de los pokemn cambiar el 30 por algun otro valor
        let idAleatorio = Int.random(in: 1...500)
        return String(idAleatorio)
    }
    
    func personalizarImageView(recibeImageView: UIImageView, recibeIV2: UIImageView, recibeIV3: UIImageView){ //funcion para personalizar las imageview
        recibeImageView.clipsToBounds = true
        recibeImageView.layer.cornerRadius = 15
        recibeIV2.clipsToBounds = true
        recibeIV2.layer.cornerRadius = 15
        recibeIV3.clipsToBounds = true
        recibeIV3.layer.cornerRadius = 15
    }
    func alerta(titulo: String, mensaje: String){//funcion para crea una alerta
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let botonAlerta = UIAlertAction(title: "Aceptar", style: .default)
        alerta.addAction(botonAlerta)
        self.present(alerta, animated: true, completion: nil)
    }
    
    func modoResponsivo(){ //funcion para el modo responsivo
        if commonUtils._2_iphone7Or8Plus(){//cada caso ya esta en common utils solo se valida y se cambian los valores
            constraintHeightMainImage.constant = 270
            constraintHeightStackImages.constant = 110
        } else if commonUtils._3_iphoneX_XS_11Pro_Mini(){
            constraintHeightMainImage.constant = 290
            constraintHeightStackImages.constant = 120
        } else if commonUtils._4_iphone12_12Pro_13_13Pro_14(){
            constraintHeightMainImage.constant = 310
            constraintHeightStackImages.constant = 130
        } else if commonUtils._5_iphone14_Pro(){
            constraintHeightMainImage.constant = 310
            constraintHeightStackImages.constant = 130
        } else if commonUtils._6_iphoneXSMax_XR_11ProMAX_11(){
            constraintHeightMainImage.constant = 350
            constraintHeightStackImages.constant = 150
        } else if commonUtils._7_iphone12_13_14Max_14Plus(){
            constraintHeightMainImage.constant = 360
            constraintHeightStackImages.constant = 160
        }
    }

}
