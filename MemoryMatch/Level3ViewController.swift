//
//  Level3ViewController.swift
//  MemoryMatch
//
//  Created by czf on 2019/1/10.
//  Copyright © 2019年 czf. All rights reserved.
//

import UIKit

class Level3ViewController: UIViewController {

    @IBOutlet weak var gameTimeLeft: UILabel!
    var startGame:Bool = false
    var lose:Bool = false
    var timer = Timer()
    var timerEnable:Bool = false
    var timerCnt = 100
    var matchCounter:Int = 0
    var guessCounter:Int = 0
    var blankTileImage:UIImage = UIImage(named: "blank的副本.png")!
    var backTileImage:UIImage = UIImage(named: "back的副本.png")!
    var isDisabled:Bool = false
    var tileFlipped:Int = -1
    var tile1:UIButton = UIButton()
    var tile2:UIButton = UIButton()
    var isMatch:Bool = false
    
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
        gameTimeLeft.text = "Time Left : 100s"
        self.lose = false
        self.shuffleTiles()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "开始第三关", message: "翻转并消除30张卡牌，你有100秒的时间！", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        if !timerEnable {
            timerEnable = true
            timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: true, block: {(timer: Timer) -> Void in
                self.timerCnt = self.timerCnt - 1
                self.gameTimeLeft.text = "Time left : \(self.timerCnt)s"
                if self.timerCnt == 0 {
                    self.loser()
                }
            })
        }
    }
    
    func loser() {
        timerEnable = false
        timer.invalidate()
        let alert = UIAlertController(title: "你失败了", message: "时间已被用完，闯关失败", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        self.lose = true
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tileClicked(_ sender: UIButton) {
        if lose {
            return
        }
        if !startGame {
            startGame = true
        }
        if isDisabled {
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
            
            self.tileFlipped = -1 //no card flipped
        }else {
            //flip the first card
            self.tileFlipped = senderID
            self.tile1 = sender as UIButton
            var tileImage:UIImage = self.tiles.object(at: senderID) as! UIImage
            sender.setImage(tileImage, for: .normal)
        }
    }
    
    func winner() {
        timer.invalidate()
        timerEnable = false
        self.gameTimeLeft.text = "You passed level 3!"
        isEnablelevel4 = true
        let alert = UIAlertController(title: "游戏胜利", message: "level 4 已解锁", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
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
