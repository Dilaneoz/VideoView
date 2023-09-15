//
//  ViewController.swift
//  VideoOrnek
//
//  Created by Dilan Öztürk on 19.02.2023.
//

import UIKit

/* <key>NSAppTransportSecurity</key>
 <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
 </dict>
 yukarıdaki kodlar info ya eklenmeli
 */

class ViewController: UIViewController {

    @IBOutlet weak var ustVideo: VideoView!
    @IBOutlet weak var altVideo: VideoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ustVideo.configure(url: "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4")
        ustVideo.isLoop = true
        ustVideo.oynat()
        
        altVideo.configure(url: "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4")
        altVideo.isLoop = true
        altVideo.oynat()
    }


}

