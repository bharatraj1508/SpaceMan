//
//  GameViewController.swift
//  SuperSpaceMan
//
//  Created by Bharat Verma on 2023-05-17.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    /*
     Mount the SKScene (Game Scene) onto it
     */
    
    var scene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //1. Configure the main view to be an SKView
        let skView = view as! SKView
        
        //2. create and configure our game scene
        //will be the size of the skView
        scene = GameScene(size: skView.bounds.size)
        scene.view?.showsPhysics = true // this will show the physics objects within our scene
        scene.view?.showsFPS = true
        
        //3. Present the scene onto the skView
        skView.presentScene(scene)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
