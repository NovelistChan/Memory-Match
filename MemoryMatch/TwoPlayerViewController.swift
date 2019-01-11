//
//  TwoPlayerViewController.swift
//  MemoryMatch
//
//  Created by czf on 2018/12/2.
//  Copyright © 2018年 czf. All rights reserved.
//

import UIKit
import AVFoundation

class TwoPlayerViewController: UIViewController {
    
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
    var matchCounter1:Int = 0
    var point1:Int = 0
    //连续消除标记
    var continue1:Int = 0
//    var guessCounter1:Int = 0
    var matchCounter2:Int = 0
    var point2:Int = 0
    var continue2:Int = 0
//    var guessCounter2:Int = 0
//    var matchCounterWin:Int = 0
    //清除时卡牌变为透明
    var blankTileImage:UIImage = UIImage(named: "blank的副本.png")!
    //原本卡牌背面图
    var backTileImage:UIImage = UIImage(named: "back的副本.png")!
    //奖励分牌：黑色星星
    var bonusTileImage:UIImage = UIImage(named: "icons03的副本.png")!
    //奖励分牌：白色星星
    var superBonusTileImage:UIImage = UIImage(named: "icons04的副本.png")!
    //惩罚牌：黑色x
    var punishTileImage:UIImage = UIImage(named: "icons08的副本.png")!
    //惩罚牌：删除标志
    var superPunishTileImage:UIImage = UIImage(named: "icons12的副本.png")!
    var isDisabled:Bool = false
    var tileFlipped:Int = -1
    var tile1:UIButton = UIButton()
    var tile2:UIButton = UIButton()
    var isMatch:Bool = false
    var player:Int = 1
//    var playerWin:Int = 0
    
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    func playBgMusic(){
        let musicPath = Bundle.main.path(forResource: "background2.mp3", ofType: nil)
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        playBgMusic()
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "双人对战模式", message: "在本模式中，不设置时间限制，双方玩家轮流翻开两张卡牌，成功配对特殊卡牌或连续消除多对卡牌可触发特殊事件", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
        gameScoreLabel.text = "Player1: \(self.point1) VS Player2: \(self.point2)"
        self.shuffleTiles()
        playBgMusic()
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func titleClicked(_ sender: UIButton) {
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
                isMatch = true
                if self.player == 1 {
                    self.matchCounter1 = self.matchCounter1 + 1
                    self.point1 = self.point1 + 1
                    self.continue1 = self.continue1 + 1
                //    self.player = 2
                }else {
                //    self.player = 1
                    self.matchCounter2 = self.matchCounter2 + 1
                    self.point2 = self.point2 + 1
                    self.continue2 = self.continue2 + 1
                }
                //self.matchCounter = self.matchCounter + 1
            } else {//连续消除个数清零
                if self.player == 1 {
                    self.continue1 = 0
                } else {
                    self.continue2 = 0
                }
            }
            isDisabled = true // disable flip
            //self.guessCounter = self.guessCounter + 1
            Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false, block: {(timer: Timer) -> Void in
                if self.isMatch == true {
                    self.tile1.setImage(self.blankTileImage, for: .normal)
                    self.tile2.setImage(self.blankTileImage, for: .normal)
                    //在消除的卡牌超过一半时，对应卡牌有可能触发奖励或惩罚事件
                    if (self.matchCounter1 + self.matchCounter2) > 8 {
                        switch(tileImage){
                        case self.bonusTileImage:
                            self.bonus()
                            break
                        case self.punishTileImage:
                            self.punish()
                            break
                        case self.superBonusTileImage:
                            self.superBonus()
                            break
                        case self.superPunishTileImage:
                            self.superPunish()
                            break
                        default: break
                        }
                    }
                    if self.player == 1 {
                        if self.continue1 >= 3 {//连续消除3对以上，获得奖励
                            self.continueBonus1()
                        }
                    } else {
                        if self.continue2 >= 3 {
                            self.continueBonus2()
                        }
                    }
                    self.isMatch = false
                }else if self.isMatch == false {
                    self.tile1.setImage(self.backTileImage, for: .normal)
                    self.tile2.setImage(self.backTileImage, for: .normal)
                }
                self.isDisabled = false
                if((self.matchCounter1 + self.matchCounter2) == (self.tiles.count / 2)) {
                    self.winner()
                }
            })
            //isDisabled = false
            if self.player == 1 {
                self.player = 2
            } else {
                self.player = 1
            }
            self.tileFlipped = -1 //no card flipped
        }else {
            //flip the first card
            self.tileFlipped = senderID
            self.tile1 = sender as UIButton
            var tileImage:UIImage = self.tiles.object(at: senderID) as! UIImage
            sender.setImage(tileImage, for: .normal)
        }
        gameScoreLabel.text = "Player1: \(self.point1) VS Player2: \(self.point2)"
        
    }
    
    func continueBonus1() {
        self.point1 = self.point1 + self.continue1
        let alert = UIAlertController(title: "获得奖励", message: "玩家1连续消除超过3对卡牌，获得奖励分！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        gameScoreLabel.text = "Player1: \(self.point1) VS Player2: \(self.point2)"
    }
    
    func continueBonus2() {
        self.point2 = self.point2 + self.continue2
        let alert = UIAlertController(title: "获得奖励", message: "玩家2连续消除超过3对卡牌，获得奖励分！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        gameScoreLabel.text = "Player1: \(self.point1) VS Player2: \(self.point2)"
    }
    
    func bonus() {
        if self.player == 1 {
            self.point1 = self.point1 + 2
            let alert = UIAlertController(title: "获得奖励", message: "玩家1获得2分奖励分！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.point2 = self.point2 + 2
            let alert = UIAlertController(title: "获得奖励", message: "玩家2获得2分奖励分！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        gameScoreLabel.text = "Player1: \(self.point1) VS Player2: \(self.point2)"
    }
    
    func superBonus() {
        if self.player == 1 {
            self.point1 = self.point1 + 4
            let alert = UIAlertController(title: "获得奖励", message: "玩家1获得4分奖励分！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.point2 = self.point2 + 4
            let alert = UIAlertController(title: "获得奖励", message: "玩家2获得4分奖励分！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        gameScoreLabel.text = "Player1: \(self.point1) VS Player2: \(self.point2)"
    }
    
    
    func punish() {
        if self.player == 1 {
            self.point1 = self.point1 - 2
            let alert = UIAlertController(title: "获得惩罚", message: "玩家1受惩罚，扣除2分！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.point2 = self.point2 - 2
            let alert = UIAlertController(title: "获得惩罚", message: "玩家2受惩罚，扣除2分！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        gameScoreLabel.text = "Player1: \(self.point1) VS Player2: \(self.point2)"
    }
    
    func superPunish() {
        if self.player == 1 {
            self.point1 = self.point1 - 4
            let alert = UIAlertController(title: "获得惩罚", message: "玩家1受惩罚，扣除4分！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.point2 = self.point2 - 4
            let alert = UIAlertController(title: "获得惩罚", message: "玩家2受惩罚，扣除4分！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        gameScoreLabel.text = "Player1: \(self.point1) VS Player2: \(self.point2)"
    }
    
    func winner() {
        if self.matchCounter1 > self.matchCounter2 {
            self.gameScoreLabel.text = "Player1 won with \(self.point1) Points!"
        } else if self.matchCounter1 < self.matchCounter2 {
            self.gameScoreLabel.text = "Player2 won with \(self.point2) Points!"
        } else if self.matchCounter1 == self.matchCounter2 {
            self.gameScoreLabel.text = "You two end up in a draw!"
        }
        
        //create alert dialog
        let alert = UIAlertController(title: "游戏已完成", message: "是否退出", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
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
