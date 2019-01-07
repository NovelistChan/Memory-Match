//
//  TwoPlayerViewController.swift
//  MemoryMatch
//
//  Created by czf on 2018/12/2.
//  Copyright © 2018年 czf. All rights reserved.
//

import UIKit

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
//    var guessCounter1:Int = 0
    var matchCounter2:Int = 0
//    var guessCounter2:Int = 0
//    var matchCounterWin:Int = 0
    //清除时卡牌变为透明
    var blankTileImage:UIImage = UIImage(named: "blank的副本.png")!
    //原本卡牌背面图
    var backTileImage:UIImage = UIImage(named: "back的副本.png")!
    //奖励分牌：黑色星星
    var bonusTileImage:UIImage = UIImage(named: "icons03的副本.png")!
    //奖励分牌：白色星星
    var superbonusTileImage:UIImage = UIImage(named: "icons04的f副本.png")!
    //惩罚牌：黑色x
    var punishTileImage:UIImage = UIImage(named: "icons08的副本.png")!
    var isDisabled:Bool = false
    var tileFlipped:Int = -1
    var tile1:UIButton = UIButton()
    var tile2:UIButton = UIButton()
    var isMatch:Bool = false
    var player:Int = 1
//    var playerWin:Int = 0
    
    @IBOutlet weak var gameScoreLabel: UILabel!
    
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
        gameScoreLabel.text = "Player1: \(self.matchCounter1) VS Player2: \(self.matchCounter2)"
        self.shuffleTiles()
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
                //    self.player = 2
                }else {
                //    self.player = 1
                    self.matchCounter2 = self.matchCounter2 + 1
                }
                //self.matchCounter = self.matchCounter + 1
            }
            isDisabled = true // disable flip
            //self.guessCounter = self.guessCounter + 1
            Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false, block: {(timer: Timer) -> Void in
                if self.isMatch == true {
                    self.tile1.setImage(self.blankTileImage, for: .normal)
                    self.tile2.setImage(self.blankTileImage, for: .normal)
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
        gameScoreLabel.text = "Player1: \(self.matchCounter1) VS Player2: \(self.matchCounter2)"
        
    }
    
    func winner() {
        if self.matchCounter1 > self.matchCounter2 {
            self.gameScoreLabel.text = "Player1 won with \(self.matchCounter1) Points!"
        } else if self.matchCounter1 < self.matchCounter2 {
            self.gameScoreLabel.text = "Player2 won with \(self.matchCounter2) Points!"
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
