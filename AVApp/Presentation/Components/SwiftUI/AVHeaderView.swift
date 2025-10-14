//
//  AVHeaderView.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

import SwiftUI

struct AVHeaderView<Subtitle: View>: View {
    let title: String
    let subtitle: () -> Subtitle

    init(title: String, @ViewBuilder subtitle: @escaping () -> Subtitle) {
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        VStack(alignment: .center, spacing: 16.0) {
            Text(title)
                .avStyle(.header1)
            subtitle()
        }
        .padding(16.0)
    }
}


#if DEBUG
#Preview {
    AVHeaderView(title: "Title") {
        Text("Subtitle")
            .avStyle(.header2)
    }
    .background(Color.avPrimary)
    .frame(width: 300)
}
#endif
