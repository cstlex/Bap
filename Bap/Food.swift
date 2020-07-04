//
//  Food.swift
//  Bap
//
//  Created by Minsoo Kim on 2020/07/04.
//  Copyright © 2020 Minsoo Kim. All rights reserved.
//

import Foundation;

struct Food: Codable, Identifiable, Equatable {
    let id: Int;
    var name: String;
    var isActivated: Bool = true;
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isActivated
    }
    
    init(id: Int) {
        self.id = id;
        name = "";
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self);
        id = try container.decode(Int.self, forKey: .id);
        name = try container.decode(String.self, forKey: .name);
        isActivated = try container.decode(Bool.self, forKey: .isActivated);
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self);
        try container.encode(id, forKey: .id);
        try container.encode(name, forKey: .name);
        try container.encode(isActivated, forKey: .isActivated);
    }
    
    static var foods: [Food] {
        let pref = UserDefaults.standard;
        guard let data = pref.data(forKey: "Items") else {
            return [];
        }
        guard let newItems = try? JSONDecoder().decode([Food].self, from: data) else {
            return [];
        }
        return newItems;
    }
    
    func save() {
        var foods = Food.foods;
        if let index = foods.firstIndex(of: self) {
            foods.remove(at: index);
            foods.insert(self, at: index);
        } else {
            foods.append(self);
        }
        foods.save();
    }
    
    public static func ==(lhs: Food, rhs:Food) -> Bool {
        return lhs.id == rhs.id;
    }
}

extension Array where Element == Food {
    func save() {
        if let data = try? JSONEncoder().encode(self) {
            let pref = UserDefaults.standard;
            pref.set(data, forKey: "Items");
            pref.synchronize();
        }
    }
}
