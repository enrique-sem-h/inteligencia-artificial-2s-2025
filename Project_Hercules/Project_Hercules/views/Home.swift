//
//  Home.swift
//  Project_Hercules
//
//  Created by ChustrupFx on 25/11/25.
//

import SwiftUI

struct Home: View {
    @State var viewModel = NewsViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [.gray, .white.opacity(0.3)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 25) {

                        SearchView(viewModel: $viewModel)
                            .padding(.top, 10)

                        if viewModel.news.isEmpty {
                            noNewsView
                                .transition(.opacity.animation(.easeInOut))
                        } else {
                            ForEach(viewModel.news) { item in
                                NewsCard(news: item)
                                    .transition(.move(edge: .bottom).combined(with: .opacity))
                            }
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("FlashFeed")
            .toolbarTitleDisplayMode(.inline)
            .foregroundStyle(.white)
        }
    }

    var noNewsView: some View {
        VStack(spacing: 12) {
            Image(systemName: "chart.line.uptrend.xyaxis")
                .font(.system(size: 55))
                .foregroundStyle(.white.opacity(0.7))

            Text("Search for a ticker to view news")
                .foregroundStyle(.white.opacity(0.8))
                .font(.headline)
        }
        .padding(.top, 80)
    }
}

struct NewsCard: View {
    let news: News

    @State private var show = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            Text(news.headline)
                .font(.headline)
                .bold()

            Text(news.description)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
                .lineLimit(3)

            HStack {
                Text(news.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)

                Spacer()

                if let feeling = news.feeling {
                    feelingBadge(feeling.feeling)
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.25), radius: 10, y: 6)
        .scaleEffect(show ? 1 : 0.95)
        .opacity(show ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                show = true
            }
        }
        .padding(.horizontal)
    }

    func feelingBadge(_ f: FeelingEnum) -> some View {
        Text(f.rawValue)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(badgeColor(f).opacity(0.8))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .font(.caption2)
    }

    func badgeColor(_ f: FeelingEnum) -> Color {
        switch f {
        case .Positive: return .green
        case .Neutral:  return .gray
        case .Negative: return .red
        }
    }
}

#Preview {
    Home()
}
