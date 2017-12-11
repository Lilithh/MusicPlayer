//
//  ViewController.swift
//  MusicPlayer
//
//  Created by wyh on 2017/12/11.
//  Copyright © 2017年 wyh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var image = UIImageView()
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //获取歌曲数据
        let musicName = "Green Light"
        let authorName = "Taylor Swift"
        let albumImage = "image"
        let currentTime: String = "1:52"
        let totalTime: String = "3:16"
        
        image = UIImageView(frame: CGRect(x:0, y:0, width: width, height: height/5*3-30))
        image.image = UIImage(named: albumImage)
        creatInformationInterFace(music: musicName, author: authorName)
        creatProgress(current: currentTime, total: totalTime)
        creatControlArea()
        
        self.view.addSubview(image)
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
    
    func creatProgress(current time1: String, total time2: String) {
        let progress = UIProgressView(progressViewStyle: .bar)
         let currentLabel = UILabel(frame: CGRect(x: 20, y: self.height/4*3-7, width: 50, height: 15))
        let totalLabel = UILabel(frame: CGRect(x: width - 70, y: self.height/4*3-7, width: 50, height: 15))
        progress.frame = CGRect(x: width/4, y: self.height/4*3, width: width/2, height: 10)
        progress.progress = 1
        currentLabel.text = time1
        currentLabel.textColor = UIColor(white: 0.7, alpha: 1)
        currentLabel.textAlignment = .left
        currentLabel.backgroundColor = .clear
        currentLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        totalLabel.text = time2
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
        let playAndPause = UIButton(type: .custom)
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
        playAndPause.frame = CGRect(x: 0, y: 0, width: 67, height: 67)
        playAndPause.center = CGPoint(x: width/2, y: height/20*17)
        playAndPause.setImage(UIImage(named: "play"), for: .normal)
        
        self.view.addSubview(musicList)
        self.view.addSubview(loveMusic)
        self.view.addSubview(previousMusic)
        self.view.addSubview(nextMusic)
        self.view.addSubview(playAndPause)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

