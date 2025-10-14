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
            AVAsyncImage(url: movie.posterUrl.map { URL(string: $0)! })
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
        .padding(8.0)
        .background(Color.avPrimary)
        .border(Color.avDark, width: 1.0)
        .cornerRadius(12.0)
        .shadow(radius: 4.0, y: 8.0)
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

#Preview {
    PreviewContainer {
        VStack {
            AVMovieSearchCell(movie: .mock)
                .frame(height: 85)
        }
    }
}
