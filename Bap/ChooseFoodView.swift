//
//  ChooseFoodView.swift
//  Bap
//
//  Created by Minsoo Kim on 2020/07/05.
//  Copyright © 2020 Minsoo Kim. All rights reserved.
//

import SwiftUI

struct ChooseFoodView: View {
    @State var content = "Tap to choose menu";
    @State var showNoFoodAlert = false;
    @State var shouldAnimateContent = false;
    
    func chooseFood() {
        let foods = Food.foods.filter { $0.isActivated }
        if foods.count == 0 {
            showNoFoodAlert = true;
        } else {
            shouldAnimateContent = false;
            showAnimation(foods: foods);
        }
    }
    
    func showAnimation(foods: [Food], currentCount: Int = 1) {
        let index = Int.random(in: 0..<foods.count);
        let food = foods[index];
        if currentCount == 25 {
            withAnimation(.linear(duration: 1.0)) {
                content = food.name;
                shouldAnimateContent = true;
            }
        } else {
            content = food.name;
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.showAnimation(foods: foods, currentCount: currentCount + 1);
            }
        }
    }
    
    var body: some View {
        let topContent = Text(content).font(.system(size: 32.0, weight: .bold, design: .default)).foregroundColor(Color.label);
        return ZStack {
            HStack {
                Spacer();
                VStack {
                    Spacer(minLength: 30.0).fixedSize();
                    if shouldAnimateContent {
                        topContent.transition(.opacity)
                    } else {
                        topContent
                    }
                    Spacer();
                }
                Spacer();
            }
            Button(action: chooseFood) {
                Text("Tap").font(.system(size: 57.0, weight: .bold, design: .default)).foregroundColor(Color.systemBackground).frame(width: 200.0, height: 200.0, alignment: .center)
            }.background(Color.label)
        }.background(Color.systemBackground).alert(isPresented: $showNoFoodAlert) {
            Alert(title: Text("No menu available"))
        }
    }
}

struct ChooseFoodView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChooseFoodView().colorScheme(.dark)
            ChooseFoodView().colorScheme(.light)
        }
    }
}
