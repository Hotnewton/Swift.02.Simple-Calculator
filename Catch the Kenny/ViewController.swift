//
//  ViewController.swift
//  Catch the Kenny
//
//  Created by Sam LEE on 4/7/2017.
//  Copyright © 2017 MacTechin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Link from Objs. 
    // Create 1~9 instance from UIimageView Obj
    @IBOutlet weak var Kenny1: UIImageView!
    @IBOutlet weak var Kenny2: UIImageView!
    @IBOutlet weak var Kenny3: UIImageView!
    @IBOutlet weak var Kenny4: UIImageView!
    @IBOutlet weak var Kenny5: UIImageView!
    @IBOutlet weak var Kenny6: UIImageView!
    @IBOutlet weak var Kenny7: UIImageView!
    @IBOutlet weak var Kenny8: UIImageView!
    @IBOutlet weak var Kenny9: UIImageView!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    //Create Instance from Lables Objs
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //set globel variables
    var score = 0
    var counter = 0
    var timer = Timer()
    var hideTimer = Timer () // for Hiding objects
    var kennyArray = [UIImageView]() //Declar UIImageView type Array for Kenny 1~9

    override func viewDidLoad() {
        super.viewDidLoad()  //when view loaded
        
        //check the highscores
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        
        if highScore == nil { //if very new startin so thers is nil stored on highScore
                highScoreLabel.text = "0"  //Dispaly just o
        }
        
        /*
        if let newScore = highScore as? Int {  // if this is some data stored on highScore and will convert to Int and strote to newScore
            highScoreLabel.text = String(newScore)
        }
         */
        
         if highScore != nil{
            highScoreLabel.text = String(describing: highScore!)
         }
        
        scoreLabel.text = "Score : \(score)"  //Init dispaly for scoreLabel
        counter = 30    //set time counter as 30 (sec)
        timeLabel.text = "\(counter)" // Int disaply for timeLable
        
        //Gesture Init. : UITapGestureRecognizer ( self, call a func)
        let recognize1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognize2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognize3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognize4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognize5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognize6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognize7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognize8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognize9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        
        //Gesture Setup kenny1.addGestureRecognizer (reconize)
        Kenny1.addGestureRecognizer(recognize1)
        Kenny2.addGestureRecognizer(recognize2)
        Kenny3.addGestureRecognizer(recognize3)
        Kenny4.addGestureRecognizer(recognize4)
        Kenny5.addGestureRecognizer(recognize5)
        Kenny6.addGestureRecognizer(recognize6)
        Kenny7.addGestureRecognizer(recognize7)
        Kenny8.addGestureRecognizer(recognize8)
        Kenny9.addGestureRecognizer(recognize9)
        
        //Enagle gesture funcation for each instance
        Kenny1.isUserInteractionEnabled = true
        Kenny2.isUserInteractionEnabled = true
        Kenny3.isUserInteractionEnabled = true
        Kenny4.isUserInteractionEnabled = true
        Kenny5.isUserInteractionEnabled = true
        Kenny6.isUserInteractionEnabled = true
        Kenny7.isUserInteractionEnabled = true
        Kenny8.isUserInteractionEnabled = true
        Kenny9.isUserInteractionEnabled = true
        
        //Countdown Timer : Init. Timer scheduleTimer () it calls countdown func
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
       
        //Object Hide Timer : Init. Object Hide Timer
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
        
        //Setup Array for Kenny for hideKenny Func
        kennyArray.append(Kenny1) //store Kenny 1 ~ 9 instance
        kennyArray.append(Kenny2)
        kennyArray.append(Kenny3)
        kennyArray.append(Kenny4)
        kennyArray.append(Kenny5)
        kennyArray.append(Kenny6)
        kennyArray.append(Kenny7)
        kennyArray.append(Kenny8)
        kennyArray.append(Kenny9)
        
        hideKenny()
        
    }

    @IBAction func resetButtonClicked(_ sender: Any) {
        
            UserDefaults.standard.removeObject (forKey: "highscore")
            UserDefaults.standard.synchronize()
            highScoreLabel.text = "0"
    }
    
    
    func increaseScore()   //Increase score  when call this func.
    {
        score += 1
        scoreLabel.text = "Score : \(score)" // Update scoreLabel display
    }
    
    func countDown () // for countDown counter and dispaly it to timeLabel.text
    {
        counter -= 1
        timeLabel.text = "\(counter)"
        
        //Game Over or Replay
        if counter == 0   //When Count is 0
        {
            timer.invalidate()     //stop timer
            hideTimer.invalidate() //stop hideTimer
            
            //hide all kenny
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            //Checking highScores and dispalyit
            if self.score > Int(highScoreLabel.text!)! {   // if the current Score is bigger then highScore
                
                
                UserDefaults.standard.set(self.score, forKey: "highscore")  //Store current score to System DB
                highScoreLabel.text = String(self.score) // Update Display
                UserDefaults.standard.synchronize() // Update System DB
            
                let newRecord = UIAlertController(title: "NEW RECORD", message: "New Record, YOu need to have rest !!! Bye~", preferredStyle: .alert)
                let ok = UIAlertAction(title:"OK", style: .default, handler: nil)
                newRecord.addAction(ok)
                self.present(newRecord, animated: true, completion: nil)
            }
            
            //Alert Creation *Important*
            let alert = UIAlertController(title: "Time", message: "Your Time is Over", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)

                let replay = UIAlertAction(title: "Replay", style: .default, handler: {(UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Secore : \(self.score)"
                self.counter = 30
                self.timeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
            })
            
            alert.addAction(replay)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    func hideKenny ()
    {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let randomNumber = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[randomNumber].isHidden = false
    }
}

