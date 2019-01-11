//
//  ChooseLevelViewController.swift
//  MemoryMatch
//
//  Created by czf on 2019/1/9.
//  Copyright © 2019年 czf. All rights reserved.
//

import UIKit
import AVFoundation

//是否触发条件使得隐藏关可见
var isDisplayLevel0:Bool = true

//是否通过之前的关卡，使得可以进入下一关
var isEnablelevel2:Bool = false
var isEnablelevel3:Bool = false
var isEnablelevel4:Bool = false

class ChooseLevelViewController: UIViewController {

    //隐藏关Level0的定义
    @IBOutlet weak var level0View: UIView!
    @IBOutlet weak var level0Button: UIButton!
    //高阶关卡是否可以进入
    @IBOutlet weak var level2Button: UIButton!
    @IBOutlet weak var level3Button: UIButton!
    @IBOutlet weak var level4Button: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        if !isEnablelevel2 || !isEnablelevel3 || !isEnablelevel4 {
            self.showInstruct()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //showInstruct()
        playBgMusic()
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        }
        if isDisplayLevel0 {
            level0View.alpha = 0.5
            level0Button.isEnabled = true
        } else {
            level0View.alpha = 0
            level0Button.isEnabled = false
        }
        if isEnablelevel2 {
            level2Button.isEnabled = true
        } else {
            level2Button.isEnabled = false
        }
        if isEnablelevel3 {
            level3Button.isEnabled = true
        } else {
            level3Button.isEnabled = false
        }
        if isEnablelevel4 {
            level4Button.isEnabled = true
        } else {
            level4Button.isEnabled = false
        }
        //showInstruct()
        // Do any additional setup after loading the view.
    }
    
    func showInstruct(){
        let alert = UIAlertController(title: "选择关卡", message: "当前环节中，你可以选择关卡来进行游戏，不过2、3、4关需要在完成前面关卡的基础上才能开启哦", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func playBgMusic(){
        let musicPath = Bundle.main.path(forResource: "background6.mp3", ofType: nil)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
