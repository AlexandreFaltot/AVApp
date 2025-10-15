//
//  AVMovieSearchCell.swift
//  AVApp
//
//  Created by Alexandre Faltot on 14/10/2025.
//

import SwiftUI
import Combine

struct AVMovieSearchCell: View {
    let movie: AVMovie

    var body: some View {
        HStack {
            AVAsyncImage(url: movie.posterUrl(.small))
                .frame(maxWidth: 60, maxHeight: 85)
                .cornerRadius(6.0)
            VStack(alignment: .leading) {
                Text(movie.title)
                    .avStyle(.header3)
                    .lineLimit(1)
                Spacer()
                dateAndGenre
                HStack(alignment: .center) {
                    Image(.avStar)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16.0, height: 16.0)
                    Text(.movieRate(rate: movie.rating.roundedTo1Decimal, numberOfRates: Int32(movie.numberOfRatings)))
                        .avStyle(.smallParagraphBold)
                }
            }
            Spacer()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(movie.cellAccessibilityLabel)
        .avCardDesign(borderWidth: 1.0, shadowOffset: .init(x: 0.0, y: 8.0))
    }

    var dateAndGenre: some View {
        Group {
            switch movie.releaseDate {
            case let releaseDate? where !movie.genres.isEmpty:
                Text(.dateAndGenre(date: DateFormatter.movieDateFormatter().string(from: releaseDate),
                                   genre: movie.genres.joined(separator: ", ")))
                Spacer()
            case let releaseDate?:
                Text(DateFormatter.movieDateFormatter().string(from: releaseDate))
                Spacer()
            case .none where !movie.genres.isEmpty:
                Text(movie.genres.joined(separator: ", "))
                Spacer()
            case .none:
                EmptyView()
            }
        }
        .avStyle(.smallParagraph)
        .lineLimit(1)
    }
}

#if DEBUG
#Preview {
    PreviewContainer {
        VStack {
            Spacer()
            AVMovieSearchCell(movie: .mock)
                .frame(height: 85)
            Spacer()
        }
        .padding(16.0)
        .background(Color.avPrimary)
    }
}
#endif
