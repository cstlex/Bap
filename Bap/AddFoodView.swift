//
//  AddFoodView.swift
//  Bap
//
//  Created by Minsoo Kim on 2020/07/05.
//  Copyright © 2020 Minsoo Kim. All rights reserved.
//

import SwiftUI;

struct AddFoodView: View {
    var isViewShowing: Binding<Bool>;
    @State var menuName = "";
    @State var isActive = true;
    
    func addFood(){
        let id = (Food.foods.last?.id ?? 0) + 1;
        var food = Food(id: id);
        food.name = menuName;
        food.isActivated = isActive;
        food.save();
        isViewShowing.wrappedValue = false;
    }
    
    var body: some View {
        VStack {
            Spacer(minLength: 30.0).fixedSize();
            HStack {
                Spacer(minLength: 16.0).fixedSize();
                TextField("Menu Name", text: $menuName).foregroundColor(Color.label).padding(8.0).cornerRadius(10.0).overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1.0))
                Spacer(minLength: 16.0).fixedSize();
            }
            VStack {
                Spacer(minLength: 28.0).fixedSize();
                HStack {
                    Spacer(minLength: 16.0).fixedSize();
                    Toggle(isOn: $isActive) {
                        Text("Activate by default?").foregroundColor(Color.label)
                    }
                    Spacer(minLength: 16.0).fixedSize();
                }
            }
            VStack {
                Spacer(minLength: 47.0).fixedSize();
                HStack {
                    Spacer(minLength: 16.0).fixedSize();
                    Button(action: addFood) {
                        Text("Add").foregroundColor(Color.systemBackground).frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center).font(.system(size: 19.0, weight: .bold, design: .default))
                    }.background(Color.label);
                    Spacer(minLength: 16.0).fixedSize();
                }
            }
            Spacer();
        }.navigationBarTitle("Add Menu", displayMode: .inline).background(Color.systemBackground)
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        let binding: Binding<Bool> = Binding.init(get: {
            return true;
        }) { (value) in
            
        }
        return Group {
            AddFoodView(isViewShowing: binding).colorScheme(.dark);
            AddFoodView(isViewShowing: binding).colorScheme(.light);
        }
    }
}
