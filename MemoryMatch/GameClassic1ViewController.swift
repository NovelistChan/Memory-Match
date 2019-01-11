//
//  GameClassic1ViewController.swift
//  MemoryMatch
//
//  Created by czf on 2018/11/30.
//  Copyright © 2018年 czf. All rights reserved.
//

import UIKit
import AVFoundation

var score:NSMutableArray = NSMutableArray()

class GameClassic1ViewController: UIViewController {

    @IBOutlet weak var gameScoreLabel: UILabel!
    var matchCounter:Int = 0
    var guessCounter:Int = 0
    var blankTileImage:UIImage = UIImage(named: "blank的副本.png")!
    var backTileImage:UIImage = UIImage(named: "back的副本.png")!
    var isDisabled:Bool = false
    var tileFlipped:Int = -1
    var tile1:UIButton = UIButton()
    var tile2:UIButton = UIButton()
    var isMatch:Bool = false
    //var timer1 = Timer()
    //var whyNotFlipCnt:Int = 0
    
    var tiles:NSMutableArray = NSMutableArray(objects:
        UIImage(named: "icons01的副本.png") as Any,
        UIImage(named: "icons02的副本.png") as Any,
        UIImage(named: "icons03的副本.png") as Any,
        UIImage(named: "icons04的副本.png") as Any,
        UIImage(named: "icons05的副本.png") as Any,
        UIImage(named: "icons06的副本.png") as Any,
        UIImage(named: "icons07的副本.png") as Any,
        UIImage(named: "icons08的副本.png") as Any,
        UIImage(named: "icons09的副本.png") as Any,
        UIImage(named: "icons10的副本.png") as Any,
        UIImage(named: "icons11的副本.png") as Any,
        UIImage(named: "icons12的副本.png") as Any,
        UIImage(named: "icons13的副本.png") as Any,
        UIImage(named: "icons14的副本.png") as Any,
        UIImage(named: "icons15的副本.png") as Any,
        UIImage(named: "icons01的副本.png") as Any,
        UIImage(named: "icons02的副本.png") as Any,
        UIImage(named: "icons03的副本.png") as Any,
        UIImage(named: "icons04的副本.png") as Any,
        UIImage(named: "icons05的副本.png") as Any,
        UIImage(named: "icons06的副本.png") as Any,
        UIImage(named: "icons07的副本.png") as Any,
        UIImage(named: "icons08的副本.png") as Any,
        UIImage(named: "icons09的副本.png") as Any,
        UIImage(named: "icons10的副本.png") as Any,
        UIImage(named: "icons11的副本.png") as Any,
        UIImage(named: "icons12的副本.png") as Any,
        UIImage(named: "icons13的副本.png") as Any,
        UIImage(named: "icons14的副本.png") as Any,
        UIImage(named: "icons15的副本.png") as Any
    )
    
    var shuffledTiles:NSMutableArray = NSMutableArray()
    
    func playBgMusic(){
        let musicPath = Bundle.main.path(forResource: "background3.mp3", ofType: nil)
        let url = URL(fileURLWithPath: musicPath!)
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url as URL)
        }catch{
            print(error)
        }
        
        audioPlayer.numberOfLoops = -1
        //-1為循環播放
        audioPlayer.volume = 5
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func shuffleTiles() {
        var tileCount:Int = tiles.count
        //var tileID:Int = 0
        for i in 0 ..< (tileCount / 2) {
          self.shuffledTiles.add(Int32(i))
          self.shuffledTiles.add(Int32(i))
        }
        for j in 0 ..< UInt32(tileCount) {
            //let index = j
            //generate random int
            var nElements:UInt32 = UInt32(tileCount)
            nElements = nElements - j
            var a = arc4random()
            var b = a % nElements
            var n = b + j
            //swap the ramdom selected images
            self.shuffledTiles.exchangeObject(at: Int(j), withObjectAt: Int(n))
            self.tiles.exchangeObject(at: Int(j), withObjectAt: Int(n))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBgMusic()
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        }
        gameScoreLabel.text = "Matches: \(self.matchCounter), Guess:\(self.guessCounter)"
        self.shuffleTiles()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        playBgMusic()
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "单人挑战模式", message: "在本模式中，不设置时间限制，玩家尽可能地通过更少的错误次数来配对所有卡牌，成功后可以保存历史记录", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func titleClicked0(_ sender: UIButton) {
        if isDisabled == true {
            return
        }
        var senderID:Int = sender.tag
        if self.tileFlipped >= 0 && senderID != self.tileFlipped {
            //flip the second card
            self.tile2 = sender as UIButton
            var lastImage:UIImage = self.tiles.object(at: self.tileFlipped) as! UIImage
            var tileImage:UIImage = self.tiles.object(at: senderID) as! UIImage
            sender.setImage(tileImage, for: .normal)
            //isDisabled = true //disable flip
            if tileImage == lastImage {
                //disable two buttons
                self.tile1.isEnabled = false
                self.tile2.isEnabled = false
                self.isMatch = true
                self.matchCounter = self.matchCounter + 1
            }
            isDisabled = true // disable flip
            self.guessCounter = self.guessCounter + 1
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                if self.isMatch == true {
                    self.tile1.setImage(self.blankTileImage, for: .normal)
                    self.tile2.setImage(self.blankTileImage, for: .normal)
                    //self.isMatch = false
                }else if self.isMatch == false {
                    self.tile1.setImage(self.backTileImage, for: .normal)
                    self.tile2.setImage(self.backTileImage, for: .normal)
                }
                self.isMatch = false
                self.isDisabled = false
                if(self.matchCounter == (self.tiles.count / 2)) {
                    self.winner()
                }
                
            }
           /* Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false, block: {(timer: Timer) -> Void in
                if self.isMatch == true {
                    self.tile1.setImage(self.blankTileImage, for: .normal)
                    self.tile2.setImage(self.blankTileImage, for: .normal)
                    //self.isMatch = false
                }else if self.isMatch == false {
                    self.tile1.setImage(self.backTileImage, for: .normal)
                    self.tile2.setImage(self.backTileImage, for: .normal)
                }
                self.isMatch = false
                self.isDisabled = false
                if(self.matchCounter == (self.tiles.count / 2)) {
                    self.winner()
                }
            })*/
            //self.whyNotFlip()
            //timer1.invalidate()
            self.tileFlipped = -1 //no card flipped
        }else {
            //flip the first card
            self.tileFlipped = senderID
            self.tile1 = sender as UIButton
            var tileImage:UIImage = self.tiles.object(at: senderID) as! UIImage
            sender.setImage(tileImage, for: .normal)
        }
        gameScoreLabel.text = "Matches: \(self.matchCounter), Guess:\(self.guessCounter)"
        
    }
    
  //  func whyNotFlip() {
  //      self.whyNotFlipCnt = self.whyNotFlipCnt + 1
  //  }
    
    func winner() {
        self.gameScoreLabel.text = "You won with \(self.guessCounter) Guesses!"
        //create alert dialog
        let date = NSDate()
        
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let strNowTime = timeFormatter.string(from: date as Date) as String
        print(strNowTime)
        let alert = UIAlertController(title: "游戏已完成", message: "是否保存", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            score.add("\(self.guessCounter)guesses " + strNowTime)
        })
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
