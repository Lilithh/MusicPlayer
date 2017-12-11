//
//  ViewController.swift
//  MusicPlayer
//
//  Created by wyh on 2017/12/11.
//  Copyright © 2017年 wyh. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {
    var image = UIImageView()
    let playAndPause = UIButton(type: .custom)
    var progress = UIProgressView()
    var currentLabel = UILabel()
    var totalLabel = UILabel()
    var mp3Player: AVAudioPlayer?
    var timer: Timer?
    var play: Bool = false
    var getTime: Bool = false
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //获取歌曲数据
        let musicResource = "Lorde - Green Light"
        let musicName = "Green Light"
        let authorName = "Lorde"
        let albumImage = "image"
        
        image = UIImageView(frame: CGRect(x:0, y:0, width: width, height: height/5*3-30))
        image.image = UIImage(named: albumImage)
        creatInformationInterFace(music: musicName, author: authorName)
        creatProgress()
        creatControlArea()
        creatPlayer(music: musicResource)
        timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(upDataTime), userInfo: nil, repeats: true)

        
        self.view.addSubview(image)
    }
    
    
    func creatPlayer(music: String) {
        let path = Bundle.main.path(forResource: music, ofType: "mp3")
        let pathURL = NSURL(fileURLWithPath: path!)
        do {
            self.mp3Player = try AVAudioPlayer(contentsOf: pathURL as URL)
            print ("initation well")
        } catch {
            mp3Player = nil
        }
        mp3Player?.prepareToPlay()
        timer?.invalidate()
        currentLabel.text = "00:00"
        totalLabel.text = "00:00"

    }
    
    

    func creatInformationInterFace(music name1: String, author name2: String) {
        let musicLabel = UILabel(frame: CGRect(x: 20, y: self.height/5*3-10, width: width-30, height: 60))
        let authorLabel = UILabel(frame: CGRect(x:20, y: self.height/5*3+45, width: width-50, height: 30))
        let unfold = UIButton(type: .custom)
        unfold.frame = CGRect(x: self.width-50, y: self.height/5*3+55, width:15, height: 8)
        musicLabel.text = name1
        musicLabel.textColor = .black
        musicLabel.textAlignment = .left
        musicLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        musicLabel.backgroundColor = .clear
        authorLabel.text = name2
        authorLabel.textAlignment = .left
        authorLabel.textColor = UIColor(white: 0.6, alpha: 1)
        authorLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        authorLabel.backgroundColor = .clear
        unfold.setImage(UIImage(named: "arrow"), for: .normal)
        unfold.imageView?.isHidden = false
        
        self.view.addSubview(musicLabel)
        self.view.addSubview(authorLabel)
        self.view.addSubview(unfold)
    }
    
    func creatProgress() {
        progress = UIProgressView(progressViewStyle: .bar)
        currentLabel = UILabel(frame: CGRect(x: 20, y: self.height/4*3-7, width: 50, height: 15))
        totalLabel = UILabel(frame: CGRect(x: width - 70, y: self.height/4*3-7, width: 50, height: 15))
        progress.frame = CGRect(x: width/4, y: self.height/4*3, width: width/2, height: 10)
        progress.progress = 1
        currentLabel.textColor = UIColor(white: 0.7, alpha: 1)
        currentLabel.textAlignment = .left
        currentLabel.backgroundColor = .clear
        currentLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        totalLabel.textColor = UIColor(white: 0.7, alpha: 1)
        totalLabel.textAlignment = .right
        totalLabel.backgroundColor = .clear
        totalLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)

        self.view.addSubview(progress)
        self.view.addSubview(currentLabel)
        self.view.addSubview(totalLabel)
    }
    
    func creatControlArea() {
        let musicList = UIButton(type: .custom)
        let loveMusic = UIButton(type: .custom)
        let previousMusic = UIButton(type: .custom)
        let nextMusic = UIButton(type: .custom)
        musicList.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        musicList.center = CGPoint(x: 30, y: height/20*17)
        musicList.setImage(UIImage(named: "music"), for: .normal)
        loveMusic.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        loveMusic.center = CGPoint(x: width - 30, y: height/20*17)
        loveMusic.setImage(UIImage(named: "heart"), for: .normal)
        previousMusic.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        previousMusic.center = CGPoint(x: width/4, y: height/20*17)
        previousMusic.setImage(UIImage(named: "back"), for: .normal)
        nextMusic.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        nextMusic.center = CGPoint(x: width/4*3, y: height/20*17)
        nextMusic.setImage(UIImage(named: "next"), for: .normal)
        self.playAndPause.frame = CGRect(x: 0, y: 0, width: 67, height: 67)
        self.playAndPause.center = CGPoint(x: width/2, y: height/20*17)
        self.playAndPause.setImage(UIImage(named: "play"), for: .normal)
        
        self.playAndPause.addTarget(self, action: #selector(playOrPause), for: .touchUpInside)
        
        self.view.addSubview(musicList)
        self.view.addSubview(loveMusic)
        self.view.addSubview(previousMusic)
        self.view.addSubview(nextMusic)
        self.view.addSubview(playAndPause)
    }
    
    @objc private func playOrPause() {
        if !play {
            mp3Player?.play()
            play = true
            self.playAndPause.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            mp3Player?.pause()
            play = false
            self.playAndPause.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    @objc func upDataTime() {
        let current = mp3Player?.currentTime
        if current != 0 {
            let total = mp3Player?.duration
            let rate = CGFloat(current!/total!)
            progress.setProgress(Float(rate), animated: true)
            if !getTime{
                let totalMin = Int(total!)/60
                let totalSec = Int(total!)%60
                var TotalMin: String = ""
                var TotalSec: String = ""
                if totalMin < 10 {
                    TotalMin = "0\(totalMin)"
                } else {
                    TotalMin = "\(totalMin)"
                }
                if totalSec < 10 {
                    TotalSec = "0\(totalSec)"
                } else {
                    TotalSec = "\(totalSec)"
                }
                self.totalLabel.text = "\(TotalMin):\(TotalSec)"
                self.getTime = true
            }
            let currentMin = Int(current!)/60
            let currentSec = Int(current!)%60
            var CurrentMin: String = ""
            var CurrentSec: String = ""
            if currentMin < 10 {
                CurrentMin = "0\(currentMin)"
            } else {
                CurrentMin = "\(currentMin)"
            }
            if currentSec < 10 {
                CurrentSec = "0\(currentSec)"
            } else {
                CurrentSec = "\(currentSec)"
            }
            self.currentLabel.text = "\(CurrentMin):\(CurrentSec)"
            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

