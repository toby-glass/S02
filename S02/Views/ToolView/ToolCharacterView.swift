//
//  ToolCharacterView.swift
//  S02
//
//  Created by Toby Glass on 05/05/2026.
//

import SwiftUI

struct ToolCharacterView: View {
    
    @Environment(CVM.self) var vm
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("喝")
                Spacer()
            }
            .padding(.top, 8)
            .padding(.bottom, 16)
            ZStack {
                Spacer()
            }
            .background(.card)
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
//            Spacer()
        }
        .padding()
        .background(.bg2)
    }
}

#Preview {
    ToolCharacterView()
}
