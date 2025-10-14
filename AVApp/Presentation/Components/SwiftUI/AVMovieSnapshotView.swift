//
//  AVMovieSnapshotView.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

import SwiftUI

struct AVMovieSnapshotView: View {
    let movie: AVMovieDetails

    var body: some View {
        HStack(spacing: 8.0) {
            AVAsyncImage(url: movie.posterUrl(.medium))
                .frame(width: 165, height: 245)
                .cornerRadius(12.0)
                .clipped()
            VStack(alignment: .leading, spacing: 0.0) {
                if let releaseDate = movie.releaseDate {
                    Text(.releaseDate(releaseDate: DateFormatter.movieDateFormatter().string(from: releaseDate)))
                    Spacer()
                }
                Text(.genre(genre: movie.genres.joined(separator: ", ")))
                Spacer()
                Text(.duration(duration: movie.runtime.asHourFormat()))
                Spacer()
                Text(.directedBy(directorName: movie.directors.joined(separator: ", ")))
                Spacer()
                AVMovieRatingView(rate: movie.rating, numberOfRates: movie.numberOfRatings)
                    .frame(alignment: .center)
            }
            .padding(.vertical, 8.0)
            .avStyle(.paragraph)
            .lineLimit(2)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(background)
    }

    var background: some View {
        AVAsyncImage(url: movie.backdropUrl(.large))
            .scaledToFill()
            .clipped()
            .opacity(0.4)
    }
}

#if DEBUG
#Preview {
    PreviewContainer {
        AVMovieSnapshotView(movie: .mock)
            .background(Color.avPrimary)
            .frame(width: 375, height: 250)
    }
}
#endif
