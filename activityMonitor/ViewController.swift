//
//  ViewController.swift
//  activityMonitor
//
//  Created by Amr Moussa on 4/1/20.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
     var player: AVAudioPlayer!
   var currntperiod = 0
    var timer = Timer()
    var startbutton :UIButton?
    var edited = false
       var secondsPassed = 0
    var textfeild :UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func activity(_ sender: UITextField) {
        if let timeTextfeild = self.view.viewWithTag(sender.tag+1) as? UITextField {
            if !edited  {
                
                animatetimertextfeild(timeTextfeild,sender)
                timeTextfeild.isHidden = false
                timeTextfeild.text = "⌛"
                if sender.text == "" {
                    sender.placeholder = "EX: goal ,activity"
                }
                else{
                    claculateTimeFromText(sender, timeTextfeild)
                    edited = true
                    
                }
                edited = true
            }
            else {
                edited = false
                if sender.text == "" {
                    sender.placeholder = ""
                     timeTextfeild.isHidden = true
                }
                else{
                    secondsPassed = 0
                    timer.invalidate()
                    textfeild = sender
                    claculateTimeFromText(sender, timeTextfeild)
                    
                        
                    
                }
            }
            
        }
        
        
    }
    
    func animatetimertextfeild(_ uifeild:UITextField,_ activityfeild:UITextField){
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseInOut, animations: {
            uifeild.transform = CGAffineTransform(translationX:  uifeild.bounds.origin.x + 100, y: uifeild.bounds.origin.y)
        }, completion: nil)
        
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            uifeild.transform = CGAffineTransform(translationX:  uifeild.bounds.origin.x , y: uifeild.bounds.origin.y)
        }, completion: nil)
        
 
        
        
    }
    @IBAction func startButtonPressed(_ sender: UIButton) {
        startbutton = sender
        secondsPassed = 0
        timer.invalidate()
         starttimer()
        
        
    }
    
    func claculateTimeFromText(_ acrivityfeild:UITextField,_ timetextfeild:UITextField){
        
        let strArr = acrivityfeild.text?.description.split(separator: " ")

    for item in strArr! {
        let part = item.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        if let intVal = Int(part) {
            timetextfeild.text = String(intVal) + " m"
            currntperiod = intVal
        }
    }

        
        
    }
    func  starttimer()  {
         timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
        
    }
    @objc func updateTimer() {
         if secondsPassed < currntperiod * 60  {
             secondsPassed += 1
//             progressBar.progress = Float(secondsPassed) / Float(totalTime)
            var currnttime = (Float(secondsPassed) / Float(currntperiod * 60 ))
//            print(currnttime)
//            var fra = String((currnttime - Float(Int(currnttime))))
//            var subindex = fra.index(fra.startIndex, offsetBy: 2)
//            var index2 = fra.index(fra.startIndex, offsetBy: 4)//will call succ 2 times
            textfeild?.setGradientBackground(currnttime)
            let mints = (Float(secondsPassed) / 60.0 )
//            print(mints)
//            print(secondsPassed , (Int(mints) * 60))
//            var  secondss = fra[subindex..<index2]
            let secondss = (secondsPassed - (Int(mints) * 60))
            let st = " \(Int(mints)):\(secondss) "
            startbutton!.setTitle(st, for: .normal )
            
         } else {
             timer.invalidate()
            startbutton!.setTitle("START",for: .normal)
             let url = Bundle.main.url(forResource: "D", withExtension: "wav")
                        player = try! AVAudioPlayer(contentsOf: url!)
                        player.play()
                        player.play()
                        player.play()
            startbutton!.setTitle("DONE", for: .normal )
            
//             let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
//             player = try! AVAudioPlayer(contentsOf: url!)
//             player.play()
         }
     }
   
    
}
extension UIView {
    func setGradientBackground(_ ratio :Float) {
      
            
        self.layer.sublayers?.remove(at: 0)
        var  num :NSNumber = NSNumber(value :ratio)
        print(num)
        let colorLeft = UIColor.systemGreen.cgColor
        let colorRight = UIColor.white.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorLeft, colorRight]
        gradientLayer.locations = [ num , num ]
        gradientLayer.startPoint = CGPoint(x: 1.0 , y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        }
   
}
