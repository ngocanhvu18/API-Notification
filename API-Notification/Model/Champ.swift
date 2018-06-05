//
//  Champ.swift
//  API-Notification
//
//  Created by Ngọc Anh on 6/5/18.
//  Copyright © 2018 Ngọc Anh. All rights reserved.
//

import Foundation



class Champ {
    var id_Champ : String
    var nameEN_Champ: String
    var nameVN_Champ : String
    var level_Champ: String
    var url_Champ : String
    
    init?(dict: DICT) {
        guard let id_Champ = dict["id_Champ"] as? String else {return nil}
        guard let nameEN_Champ = dict["nameEN_Champ"] as? String else {return nil}
        guard let nameVN_Champ = dict["nameVN_Champ"] as? String else { return nil }
        guard let level_Champ = dict["level_Champ"] as? String else { return nil }
        guard let url_Champ = dict["url_Champ"] as? String else { return nil }
        self.id_Champ = id_Champ
        self.nameEN_Champ = nameEN_Champ
        self.nameVN_Champ = nameVN_Champ
        self.level_Champ = level_Champ
        self.url_Champ = url_Champ
    }
}


