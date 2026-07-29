//
//  ButtonPrimary.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import SwiftUI

struct ButtonPrimaryView: View {
    let title: String
    var icon: String = ""

    var body: some View {
        Label(title, systemImage: icon)
            .font(.system(size: 16))
            .fontWeight(.medium)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(.white)
            .clipShape(Capsule())
    }
}
