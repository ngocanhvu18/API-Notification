//
//  DataService.swift
//  API-Notification
//
//  Created by Ngọc Anh on 6/5/18.
//  Copyright © 2018 Ngọc Anh. All rights reserved.
//


import UIKit
class DataService {
    static let shared: DataService = DataService()
    
    
// su dung NotifiCation
    private var _champs: [Champ]?
    var champs: [Champ] {
        get {
            if _champs == nil {
                getDataAPI()
            }
            return _champs ?? []
        }
    }

    func getDataAPI() {
        _champs = []

        guard let urlString = URL(string: "http://infomationchampion.pe.hu/showInfo.php?index=1&number=20") else {return}

        let urlRequest = URLRequest(url: urlString )
        DispatchQueue.global().async {
            let champs = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in

                guard error == nil else{
                    print(error!.localizedDescription)
                    return
                }
                guard let dataChampe = data else{return}
                do {
                    let result = try JSONSerialization.jsonObject(with:dataChampe , options: .mutableContainers)
                    guard let champsObject = result as? [DICT] else { return }
                    for champObj in champsObject {
                        if let champ = Champ(dict: champObj) {
                            self._champs?.append(champ)
                        }
                    }
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name.init("EndUpdateData"), object: nil)
                    }
                }
                catch{
                    print(error.localizedDescription)
                }

            })
            champs.resume()
        }
    }

}
