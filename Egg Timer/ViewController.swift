//
//  ViewController.swift
//  Egg Timer
//
//  Created by Sagar Baloch on 21/10/2019.
//  Copyright © 2019 Sagar Baloch. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
//  Label Instance
    @IBOutlet weak var label: UILabel!
//  Progress Bar Instance
    @IBOutlet weak var progressBar: UIProgressView!
//  Variables for Percentage Calculation
    var totalTime:Float=0
    var secondsPass:Float=0
    var player: AVAudioPlayer!
//  Starting Function
    override func viewDidLoad() {
        super.viewDidLoad()
        var transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 6.0)
        progressBar.transform = transform
    }
//  Continously Updating Timer Function
    @objc func updateCounter() {
        if secondsPass<totalTime{
            secondsPass+=1
            var percentage = (secondsPass/totalTime)
            progressBar.progress=percentage
        }else{
            timer.invalidate()
            playSound()
            label.text="                Done"
            progressBar.progress=0
            secondsPass=0
        }
    }
//  Timer Instance
    var timer=Timer()
//  Eggs Time
    let eggTimer=["Soft":10,"Medium":420,"Hard":720]
//  Button Pressed
    @IBAction func hardnessSelected(_ sender: UIButton) {
        label.text="                Boiling"
        timer.invalidate()
        let hardness=sender.currentTitle
        totalTime=Float(eggTimer[hardness!]!)
        timer=Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
//  Function for Playing Sound
    func playSound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
