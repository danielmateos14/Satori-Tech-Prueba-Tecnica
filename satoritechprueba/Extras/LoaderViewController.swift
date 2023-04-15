//
//  LoaderViewController.swift
//  satoritechprueba
//
//  Created by djdenielb on 15/04/23.
//

import UIKit

import UIKit
import SwiftyGif //libreria para usar gifs animados

class LoaderViewController: UIViewController {
    
    //Instancias de los elementos graficos
    @IBOutlet weak var viewBackgroundLoader: UIView!
    @IBOutlet weak var imageViewNewLoader: UIImageView!
    @IBOutlet weak var stackLoader: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gif = try! UIImage(gifName: "loader")//asignacion del gif con la libreria swiftygif
        self.imageViewNewLoader.setGifImage(gif, loopCount: -1)//repeticion del gif
        viewBackgroundLoader.backgroundColor = .black.withAlphaComponent(0.5)//color de fondo con transparencia
        stackLoader.backgroundColor = .black.withAlphaComponent(0.5)//color de fondo con transparencia
        viewBackgroundLoader.layer.cornerRadius = 10 //Redondeo de las esquinas
        stackLoader.layer.cornerRadius = 10 //Redondeo de las esquinas
        self.view.backgroundColor = .black.withAlphaComponent(0.2) //color de fondo con transparencia

        //Este dispatch es para que la ventana se cierre sola cada 3.5s
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5){
            self.dismiss(animated: true)
        }
    }
}
