//
//  FoodItemView.swift
//  Bap
//
//  Created by Minsoo Kim on 2020/07/04.
//  Copyright © 2020 Minsoo Kim. All rights reserved.
//

import SwiftUI;

public extension Color {

    #if os(macOS)
    static let systemBackground = Color(NSColor.windowBackgroundColor);
    static let secondaryBackground = Color(NSColor.underPageBackgroundColor);
    static let tertiaryBackground = Color(NSColor.controlBackgroundColor);
    static let label = Color(NSColor.label);
    #else
    static let systemBackground = Color(UIColor.systemBackground);
    static let secondaryBackground = Color(UIColor.secondarySystemBackground);
    static let tertiaryBackground = Color(UIColor.tertiarySystemBackground);
    static let label = Color(UIColor.label);
    #endif
}

struct FoodItemView: View {
    var food: Food;
    
    @State var isOn: Bool = true;
    
    init(food: Food) {
        self.food = food;
    }
    
    func setIsOn(){
        isOn = food.isActivated;
    }
    
    func activationChanged(value: Bool){
        if value == food.isActivated {
            return;
        }
        var items = Food.foods;
        let id = food.id;
        items = items.map { (food) -> Food in
            var food = food;
            if food.id == id {
                food.isActivated = value;
            }
            return food;
        }
        items.save();
    }
    
    var body: some View {
        HStack {
            Toggle(isOn: $isOn) {
                Text(food.name).foregroundColor(Color.label)
            }.onReceive([isOn].publisher.first(), perform: activationChanged(value:))
        }.background(Color.systemBackground).onAppear(perform: setIsOn)
    }
}

struct FoodItemView_Previews: PreviewProvider {
    static var previews: some View {
        var food = Food(id: 1);
        food.name = "item";
        food.isActivated = false;
        return Group {
            FoodItemView(food: food).colorScheme(.dark);
            FoodItemView(food: food).colorScheme(.light);
        }
    }
}
