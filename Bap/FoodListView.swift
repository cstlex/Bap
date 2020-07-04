//
//  FoodListView.swift
//  Bap
//
//  Created by Minsoo Kim on 2020/07/04.
//  Copyright © 2020 Minsoo Kim. All rights reserved.
//

import SwiftUI;

struct FoodListView: View {
    @State var foods: [Food] = [];
    @State var isShowingAdd = false;
    
    func reloadFoods(){
        foods = Food.foods;
    }
    
    var body: some View {
        return Group {
            List {
                ForEach(foods, id: \.id) { FoodItemView(food: $0) }
                Button(action: {
                    self.isShowingAdd = true;
                }) {
                    Image(systemName: "plus")
                }
                NavigationLink(destination: AddFoodView(isViewShowing: $isShowingAdd), isActive: $isShowingAdd) {
                    EmptyView();
                }.hidden()
            }
            
        }.onAppear(perform: reloadFoods).navigationBarTitle("Menus", displayMode: .inline)
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        var food = Food(id: 1);
        food.name = "first item";
        food.isActivated = true;
        [food].save();
        return Group {
            FoodListView().colorScheme(.dark);
            FoodListView().colorScheme(.light);
        }
    }
}
