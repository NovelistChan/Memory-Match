//
//  Level0ViewController.swift
//  MemoryMatch
//
//  Created by czf on 2019/1/10.
//  Copyright © 2019年 czf. All rights reserved.
//

import UIKit

class Level0ViewController: UIViewController {

    
    @IBOutlet weak var hidddenPhaseCome: UILabel!
    var startGame:Bool = false
    var lose:Bool = false
    var timer = Timer()
    var timerEnable:Bool = false
    var timerCnt = 120
    var matchCounter:Int = 0
    var guessCounter:Int = 0
    var blankTileImage:UIImage = UIImage(named: "blank的副本.png")!
    var backTileImage:UIImage = UIImage(named: "back的副本.png")!
    var isDisabled:Bool = false
    var tileFlipped:Int = -1
    var tile1:UIButton = UIButton()
    var tile2:UIButton = UIButton()
    var isMatch:Bool = false
    
    //每种事件只会被调用一次
    var called1:Bool = false
    var called3:Bool = false
    var called6:Bool = false
    var called9:Bool = false
    var called12:Bool = false
    var called14:Bool = false
    
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
        hidddenPhaseCome.text = "Time left : 120s"
        self.lose = false
        self.shuffleTiles()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "开始第四关", message: "翻转并消除30张卡牌，你有120秒的时间！在消除过程中会触发一些独特的事件，正确完成事件会得到奖励时间，反之扣除时间", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        if !timerEnable {
            timerEnable = true
            timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: true, block: {(timer: Timer) -> Void in
                self.timerCnt = self.timerCnt - 1
                self.hidddenPhaseCome.text = "Time left : \(self.timerCnt)s"
                if self.timerCnt == 0 {
                    self.loser()
                }
                switch(self.matchCounter){
                case 1:
                    self.when1Match()
                    break
                case 3:
                    self.when3Match()
                    break
                case 6:
                    self.when6Match()
                    break
                case 9:
                    self.when9Match()
                    break
                case 12:
                    self.when12Match()
                    break
                case 14:
                    self.when14Match()
                    break
                default:
                    break
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
    
    func when1Match() {
        if called1 {
            return
        } else {
            called1 = true
        }
        let alert = UIAlertController(title: "新事件", message: "辅佐唐太宗开创“贞观之治”的文徳皇后的姓氏是下面哪个复姓", preferredStyle: .alert)
        let rightAction = UIAlertAction(title: "长孙", style: .default, handler: {
            action in
            self.bonus()
        })
        let wrongAction1 = UIAlertAction(title: "欧阳", style: .default, handler: {
            action in
            self.punish()
        })
        let wrongAction2 = UIAlertAction(title: "端木", style: .default, handler: {
            action in
            self.punish()
        })
        let wrongAction3 = UIAlertAction(title: "百里", style: .default, handler: {
            action in
            self.punish()
        })
        alert.addAction(wrongAction1)
        alert.addAction(wrongAction2)
        alert.addAction(wrongAction3)
        alert.addAction(rightAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func when3Match() {
        if called3 {
            return
        } else {
            called3 = true
        }
        let alert = UIAlertController(title: "新事件", message: "下面哪种程序设计语言的英文原意是一种动物？", preferredStyle: .alert)
        let rightAction = UIAlertAction(title: "Python", style: .default, handler: {
            action in
            self.bonus()
        })
        let wrongAction = UIAlertAction(title: "Java", style: .default, handler: {
            action in
            self.punish()
        })
        alert.addAction(rightAction)
        alert.addAction(wrongAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func when6Match() {
        if called6 {
            return
        } else {
            called6 = true
        }
        let alert = UIAlertController(title: "新事件", message: "当时明月在，曾照彩云归。这一句诗出自晏几道的《临江仙·梦后楼台高锁》", preferredStyle: .alert)
        let rightAction = UIAlertAction(title: "正确", style: .default, handler: {
            action in
            self.bonus()
        })
        let wrongAction = UIAlertAction(title: "错误", style: .default, handler: {
            action in
            self.punish()
        })
        alert.addAction(rightAction)
        alert.addAction(wrongAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func when9Match() {
        if called9 {
            return
        } else {
            called9 = true
        }
        let alert = UIAlertController(title: "新事件", message: "经典动漫《灌篮高手》中的主题曲《直到世界尽头》的原唱是乐队WANDS，该乐队的主唱是", preferredStyle: .alert)
        let rightAction = UIAlertAction(title: "上杉升", style: .default, handler: {
            action in
            self.bonus()
        })
        let wrongAction = UIAlertAction(title: "坂井泉水", style: .default, handler: {
            action in
            self.punish()
        })
        alert.addAction(rightAction)
        alert.addAction(wrongAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func when12Match() {
        if called12 {
            return
        } else {
            called12 = true
        }
        let alert = UIAlertController(title: "新事件", message: "足球场上的名句“Why always me”出自哪位著名球星", preferredStyle: .alert)
        let rightAction = UIAlertAction(title: "巴洛特利", style: .default, handler: {
            action in
            self.bonus()
        })
        let wrongAction1 = UIAlertAction(title: "巴乔", style: .default, handler: {
            action in
            self.punish()
        })
        let wrongAction2 = UIAlertAction(title: "齐达内", style: .default, handler: {
            action in
            self.punish()
        })
        let wrongAction3 = UIAlertAction(title: "罗马里奥", style: .default, handler: {
            action in
            self.punish()
        })
        alert.addAction(wrongAction2)
        alert.addAction(wrongAction3)
        alert.addAction(rightAction)
        alert.addAction(wrongAction1)
        self.present(alert, animated: true, completion: nil)
    }
    
    func when14Match() {
        if called14 {
            return
        } else {
            called14 = true
        }
        let alert = UIAlertController(title: "新事件", message: "好氧生物的代谢途径三羧酸循环发生在细胞的线粒体内部？", preferredStyle: .alert)
        let rightAction = UIAlertAction(title: "正确", style: .default, handler: {
            action in
            self.bonus()
        })
        let wrongAction = UIAlertAction(title: "错误", style: .default, handler: {
            action in
            self.punish()
        })
        alert.addAction(rightAction)
        alert.addAction(wrongAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func bonus() {
        timerCnt = timerCnt + 20
        let alert = UIAlertController(title: "回答正确", message: "获得20秒奖励时间", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func punish() {
        timerCnt = timerCnt - 20
        let alert = UIAlertController(title: "回答错误", message: "剩余时间减少20秒！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
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
        self.hidddenPhaseCome.text = "You passed level 0!"
        let alert = UIAlertController(title: "游戏胜利", message: "恭喜你，已经通关了全部的关卡。除了经典玩法以外，还可以在挑战模式中挑战自己的极限哦", preferredStyle: .alert)
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
