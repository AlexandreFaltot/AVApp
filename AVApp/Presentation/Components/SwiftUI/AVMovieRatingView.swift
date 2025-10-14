//
//  AVMovieRatingView.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//


import SwiftUI

struct AVMovieRatingView: View {
    let rate: Double
    let numberOfRates: Int
    private let starRange: Range<Int> = 1..<6

    var body: some View {
        VStack(spacing: 4) {
            Text(.movieRate(rate: rate.roundedTo1Decimal, numberOfRates: Int32(numberOfRates)))
                .avStyle(.header3)
            HStack(spacing: 2) {
                ForEach(starRange, id: \.self) { index in
                    ZStack {
                        Image(.avStarEmpty)
                            .resizable()
                            .frame(width: 18, height: 18)
                        if Double(index) < rate + 1 {
                            let fillPercentage = Double(index) <= rate ? 1 : 1 - Double(index) + rate
                            Image(.avStar)
                                .resizable()
                                .frame(width: 18, height: 18)
                                .partialMask(fillPercentage)
                        }
                    }
                }
            }
        }
        .padding(.all, 8.0)
        .background(.avPrimary)
        .cornerRadius(16.0)
        .shadow(radius: 2, y: 4)
        .avStyle(.paragraphBold)
    }
}

#Preview {
    AVMovieRatingView(rate: 2.542, numberOfRates: 23)
}
