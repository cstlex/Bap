//
//  ItemListView.swift
//  Bap
//
//  Created by Minsoo Kim on 2020/07/04.
//  Copyright © 2020 Minsoo Kim. All rights reserved.
//

import SwiftUI;

struct FoodListView: View {
    @State var foods: [[String:Any]] = [];
    
    func reloadFoods(){
        guard let newItems =
    }
    
    var body: some View {
        return List {
            
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
    }
}
