//
//  DataService.swift
//  API-Notification
//
//  Created by Ngọc Anh on 6/5/18.
//  Copyright © 2018 Ngọc Anh. All rights reserved.
//

import UIKit
typealias DICT = Dictionary<AnyHashable, Any>


class DataService {
    static let shared: DataService = DataService()
    var champs :[Champ]?
    
    func getDataAPI(){
        guard let url = URL(string: "http://infomationchampion.pe.hu/showInfo.php?index=1&number=20") else {
            return
        }
        let request = URLRequest(url: url)
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                guard error == nil else{
                    print(error!.localizedDescription)
                    return
                }
                guard let aData = data else{return}
                    do{
                        guard let results = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? [DICT] else {return}
                        for heroObject in results {
                            if let hero = Champ(dict: heroObject) {
                                self.champs?.append(hero)
                                
                            }
                        }
                        
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: NSNotification.Name.init("update"), object: nil)
                        }                    }
                    catch{
                        print(error.localizedDescription)
                    }
                
            })
            task.resume()
        }
    }
}
