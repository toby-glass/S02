//
//  HomeToolButton.swift
//  S02
//
//  Created by Toby Glass on 05/05/2026.
//

import SwiftUI

struct HomeToolButton: View {
    
    @Environment(CVM.self) var vm
    var tool: HomeToolType
    
    var body: some View {
        Button {
            tool.action(vm)
        } label: {
            HStack(spacing: 4) {
                Image(tool.icon)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(tool.name)
            }
            .fixedSize()
//            .padding(8)
            .background(.background.opacity(0.001))
        }
    }
}

//#Preview {
//    HomeToolButton()
//}
