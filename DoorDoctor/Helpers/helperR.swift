//
//  helperR.swift
//  DoorDoctor
//
//  Created by Evneet kaur on 2020-04-15.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import Foundation


dynamic var yt_Videos: YTVideo? = nil


func fetchVideos(remediName : String){
    var rName = remediName
    rName = rName.replacingOccurrences(of: "\n", with: "", options: .caseInsensitive)
    rName = rName.replacingOccurrences(of: "\r", with: "", options: .caseInsensitive)
    rName = rName.replacingOccurrences(of: "\t", with: "", options: .caseInsensitive)
    rName = rName.replacingOccurrences(of: " ", with: "%20", options: .caseInsensitive)
    
    if let url = URL(string: (BASE_URL1+"&q="+"\(rName.replacingOccurrences(of: " ", with: "%20"))"+BASE_URL2)){
        print("video url//////////////////////////////////////",url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("inside url session////////////////////////")
            guard data == nil else{
                if let _ = String(data: data!, encoding: .utf8){
                    do{
                        print("inside url do////////////////")
                        let ytVideo =  try JSONDecoder().decode(YTVideo.self, from: data!)
                        
                         print("after json decoder.......................")
                        
                        yt_Videos = ytVideo
                        loadImage(items: ytVideo.items)
                        
                    }catch{
                        print(error)
                    }
                }
                
                return
            }
        }.resume()
    }
}


func loadImage(items: [Item]){
    
    images = []
    items.forEach { (item) in
        DispatchQueue.global(qos: .userInitiated).async {
            do{
                let data = try Data(contentsOf: URL(string: (item.snippet.thumbnails.high.url))!)
                images.append(data)
            }catch{
                print("unable to load image:\(error)")
            }
        }
    }
    
}


let API_KEY : String = "AIzaSyB45lwuNXNnXYsc3WHA1QyJKIkxqE-Rb7A"

let BASE_URL1: String = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=50"

let BASE_URL2 : String = "&type=video&key=\(API_KEY)"

let PLAY_URL : String = "https://www.youtube.com/embed/"
