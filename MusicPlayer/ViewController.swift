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

class ViewController: UIViewController, MyProgressDelegate {
   
    
    var image = UIImageView()
    let playAndPause = UIButton(type: .custom)
     let loveMusic = UIButton(type: .custom)
    var progress = TouchedAbleProgress()
    var currentLabel = UILabel()
    var totalLabel = UILabel()
    var mp3Player: AVAudioPlayer?
    var timer: Timer?
    var tapped: Float?
    var totalTime: TimeInterval?
    var musicResource: [String] = ["Lorde - Green Light"]
    var myLoveMusic: [String] = []
    var isLoved: [Bool] = [false]
    var currentMusic: Int!
    var play: Bool = false
    var getTime: Bool = false
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    var musicName: String?
    var authorName: String?
    var albumImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //获取歌曲数据
        
        //在这里声明progress.delegate将不能代理传值
        self.currentMusic = 0
        creatPlayer(music: musicResource[currentMusic])
        creatProgress()
        creatControlArea()
        creatInformationInterFace(music: musicName ?? "Unkonw", author: authorName ?? "Unknow")
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(upDataTime), userInfo: nil, repeats: true)
        let replaceImage = UIImage(named: "image")
        image = UIImageView(frame: CGRect(x:0, y:0, width: width, height: height/5*3-30))
        image.image = albumImage ?? replaceImage
        self.view.addSubview(image)
    }
    
    func transChanged(progress: TouchedAbleProgress, value: Float) {
        self.tapped = value
        if totalTime != nil {
            self.mp3Player?.currentTime = totalTime!*Double(value)
            print(value)
        }
    }
    
    func creatPlayer(music: String) {
        let path = Bundle.main.path(forResource: music, ofType: "mp3")
        let pathURL = NSURL(fileURLWithPath: path!)
        let urlAssret = AVURLAsset(url: pathURL as URL, options: nil)
        for format in urlAssret.availableMetadataFormats {
            for mediaData in urlAssret.metadata(forFormat: format) {
                if mediaData.commonKey?.rawValue == "title" {
                    self.musicName = mediaData.value as? String
                }
                if mediaData.commonKey?.rawValue == "artist" {
                    self.authorName = mediaData.value as? String
                }
                if mediaData.commonKey?.rawValue == "artwork" {
                    self.albumImage = UIImage(data: mediaData.value as! Data)!
                }
            }
        }
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
        progress = TouchedAbleProgress()
        currentLabel = UILabel(frame: CGRect(x: 20, y: self.height/4*3-7, width: 50, height: 15))
        totalLabel = UILabel(frame: CGRect(x: width - 70, y: self.height/4*3-7, width: 50, height: 15))
        progress.frame = CGRect(x: width/4, y: self.height/4*3, width: width/2, height: 10)
        progress.progress = 1
        self.progress.delegate = self
        progress.transform = CGAffineTransform.init(scaleX: 1.0, y: 2.0)
        progress.slideSquare.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.5)
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
        let previousMusic = UIButton(type: .custom)
        let nextMusic = UIButton(type: .custom)
        musicList.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        musicList.center = CGPoint(x: 30, y: height/20*17)
        musicList.setImage(UIImage(named: "music"), for: .normal)
        musicList.setImage(UIImage(named: "player"), for: .highlighted)
        loveMusic.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        loveMusic.center = CGPoint(x: width - 30, y: height/20*17)
        loveMusic.setImage(UIImage(named: "heart"), for: .normal)
        previousMusic.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        previousMusic.center = CGPoint(x: width/4, y: height/20*17)
        previousMusic.setImage(UIImage(named: "back"), for: .normal)
        previousMusic.setImage(UIImage(named: "rewind"), for: .highlighted)
        nextMusic.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        nextMusic.center = CGPoint(x: width/4*3, y: height/20*17)
        nextMusic.setImage(UIImage(named: "next"), for: .normal)
        nextMusic.setImage(UIImage(named: "forward"), for: .highlighted)
        self.playAndPause.frame = CGRect(x: 0, y: 0, width: 67, height: 67)
        self.playAndPause.center = CGPoint(x: width/2, y: height/20*17)
        self.playAndPause.setImage(UIImage(named: "play"), for: .normal)
        
        self.playAndPause.addTarget(self, action: #selector(playOrPause), for: .touchUpInside)
        self.loveMusic.addTarget(self, action: #selector(loveOrDisloveThisMusic), for: .touchUpInside)
        previousMusic.addTarget(self, action: #selector(previouss), for: .touchUpInside)
        nextMusic.addTarget(self, action: #selector(nextt), for: .touchUpInside)
        musicList.addTarget(self, action: #selector(listt), for: .touchUpInside)
        
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
    @objc func loveOrDisloveThisMusic() {
        if !isLoved[currentMusic] {
            self.myLoveMusic.append(musicResource[currentMusic])
            self.loveMusic.setImage(UIImage(named: "redHeart"), for: .normal)
            self.isLoved[currentMusic] = true
        } else {
            self.loveMusic.setImage(UIImage(named: "heart"), for: .normal)
            self.myLoveMusic.remove(at: currentMusic)
            self.isLoved[currentMusic] = false
        }
    }
    @objc func previouss() {
        //do something
    }
    @objc func nextt() {
        //do something
    }
    @objc func listt() {
        // summon the music list
    }
    
    
    @objc func upDataTime() {
        let current = mp3Player?.currentTime
        if current != 0 {
            let total = mp3Player?.duration
            let rate = CGFloat(current!/total!)
            progress.setProgress(Float(rate), animated: true)
            if !getTime{
                totalTime = total
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
            self.progress.slideSquare.center = CGPoint(x: CGFloat(self.progress.progress)*self.progress.bounds.size.width, y: self.progress.bounds.size.height/2)
//            print(self.tapped ?? "boo")
        }
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

protocol MyProgressDelegate: NSObjectProtocol {
    func transChanged(progress: TouchedAbleProgress, value: Float)
}


