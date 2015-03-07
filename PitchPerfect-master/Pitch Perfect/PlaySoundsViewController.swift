//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Hugo Adolfo Perez Solorzano on 07/03/15.
//  Copyright (c) 2015 BMGH. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audio = AVAudioPlayer()
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // var filePathUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!)
        var error:NSError?
        
        audio = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: &error)
        //audio = AVAudioPlayer(contentsOfURL: filePathUrl, error: &error)
        audio.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func playSlow(sender: AnyObject) {
        self.playAudioWithRate(0.5)

    }

    
    @IBAction func playFast(sender: AnyObject) {
        self.playAudioWithRate(2.0)
    }
    
    
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        
        playAudioWithVariablePitch(1000)
        
    }
    
    
    @IBAction func playDarthvaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    func playAudioWithVariablePitch(pitch: Float) {
        audio.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    @IBAction func playStop(sender: AnyObject) {
        audio.stop()
    }
    
    func playAudioWithRate(rate:Float){
        audio.stop()
        audio.rate = rate
        audio.currentTime = 0.0
        audio.play()
    }
    
}
