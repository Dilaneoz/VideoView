//
//  VideoView.swift
//  VideoOrnek
//
//  Created by Dilan Öztürk on 19.02.2023.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class VideoView : UIView {
    
    // design pattern ler sayesinde hem daha düzgün kod yazabiliriz hem de daha önce yaşanmış sorunları çözer. örneğin singleton design pattern i bir nesnenin birden fazla kez oluşturulması gerektiği durumlarda her seferinde o nesneyi yeniden oluşturmak yerine o nesneyi bir kere oluştururuz ve o nesneyle ilgili tekrar talebimiz olması durumunda varolan nesne üzerinden işlemleri gerçekleştiririz. Factory design pattern i, bu nesne oluşturma işlemlerini soyutlanmış bir fabrikaya atamamızı sağlar. Builder design pattern, class lardan nesne oluştururken constructor ları daha iyi yönetebilmemiz ile ilgili bir patern. Prototype design pattern ise, oluşturduğumuz nesnenin bir prototipinin oluşturulması ile ilgilidir. structrual daki design patternler decorator de bir nesneye onu çok fazla değiştirmemize gerek kalmadan yeni özellikleri dekore etmekle ilgilidir. Behavioural daki observer design pattern i, bir nesnedeki değişikleri gözlemlemekle ilgilidir. gözlemlediğimiz bir nesne vardır ve onu gözleyenler vardır. nesnede bir değişiklik olduğunda, o nesne bende bir değişiklik oldu ve bunu size bildiricem der
    
    var playerLayer : AVPlayerLayer?
    var player : AVPlayer?
    var isLoop : Bool = false // ilgili video oynamaya devam ediyor mu etmiyor mu
    
    
    
    required init?(coder aDecoder : NSCoder) {
        
        super.init(coder: aDecoder) // bu videoview ın constructor ına bir değer geldiğinde bu gelen değeri türemiş olduğu class ın constructor ına gönder
        
    }
    
    func configure(url : String) {
        
        if let videoUrl = URL(string: url){
            
            player = AVPlayer(url: videoUrl) // maindeki view ın üzerinde playerLayer dediğimiz bir katman olucak. video oynatıcı da bu katman üzerinde işlemleri yapar
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = bounds // player ın çerçevesini bulunduğu alana eşitle
            playerLayer?.videoGravity = AVLayerVideoGravity.resize
                  
            if let playerLayer = self.playerLayer{
                layer.addSublayer(playerLayer) // playerLayer ı view ımıza ekledik
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoKontrol), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.player?.currentItem) // video nun bitip bitmediğini bize bildiren kod. notification center, nesnelerdeki gözlemleri bize bildiren bir nesnedir. yani bu videonun bittiğiyle ilgili bir durum gerçekleşirse, bu yayından sorumlu fonksiyonumuz, videoKontrol, devreye girer
        // yani uygulamamızın içinde bir olay olduğunda örneğin bir mesaj geldiğinde ya da video durduğunda bunu gözlemleyecek fonksiyon sensin deriz (yukarıdaki fonksiyonda bunu yazdık)
        
    }
    
    func oynat () {
        
        if player?.timeControlStatus != AVPlayer.TimeControlStatus.playing {
            player?.play()
        }
        
    }
    
    func duraklatma() {
        
        player?.pause()
        
    }
    
    func durdur () {
        
        player?.pause()
        player?.seek(to: CMTime.zero)
        
    }
    
    @objc func videoKontrol (_ notification : Notification) { // @objc ile bir fonksiyonu bir objeye tanımlayabiliriz. örneğin kodla bir buton oluşturma ya da başka bir olaya bağlamak istediğimiz bir fonksiyon olursa @objc ile ilgili fonksiyonu bağlayabiliriz.
        // bir fonksiyonu @objc keyword uyle tanımladığımızda, bu fonksiyonu dinamik olarak bir butona ya da başka bir şeye bağlayabiliriz
        
        if isLoop { // isLoop true ya döndüyse videomuz bitti demektir
            player?.pause()
            player?.seek(to: CMTime.zero) // başa git
            player?.play()
        }
        
    }
    
}
