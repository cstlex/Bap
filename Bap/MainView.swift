//
//  MainView.swift
//  Bap
//
//  Created by Minsoo Kim on 2020/07/04.
//  Copyright © 2020 Minsoo Kim. All rights reserved.
//

import SwiftUI;

struct MainView: View {
    var body: some View {
        TabView {
            NavigationView {
                FoodListView()
            }.tabItem {
                Image(systemName: "list.bullet")
                Text("Menu List")
            }
            ChooseFoodView().tabItem {
                Image(systemName: "star.circle.fill")
                Text("Choose")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView().colorScheme(.dark);
            MainView().colorScheme(.light);
        }
    }
}
