//
//  ViewController.swift
//  MemoryMatch
//
//  Created by czf on 2018/11/18.
//  Copyright © 2018年 czf. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //var ButtonSound = NSURL(fileURLWithPath: Bundle.mainBundle.pathForResource("tamborine", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    
    /* var Bgm = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Waiting-in-the-Woods", ofType: "mp3")!), error: nil) */
    
    func playBgMusic(){
        let musicPath = Bundle.main.path(forResource: "background1.mp3", ofType: nil)
        let url = URL(fileURLWithPath: musicPath!)
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url as URL)
        }catch{
            print(error)
        }
        
        audioPlayer.numberOfLoops = -1
        //-1為循環播放
        audioPlayer.volume = 10
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBgMusic()
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        playBgMusic()
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        }
    }
}

