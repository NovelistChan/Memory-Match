//
//  AboutUsViewController.swift
//  MemoryMatch
//
//  Created by czf on 2019/1/9.
//  Copyright © 2019年 czf. All rights reserved.
//

import UIKit
import AVFoundation

class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        playBgMusic()
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        }
        // Do any additional setup after loading the view.
    }
    
    func playBgMusic(){
        let musicPath = Bundle.main.path(forResource: "background5.mp3", ofType: nil)
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
