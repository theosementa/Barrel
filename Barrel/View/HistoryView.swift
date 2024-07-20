//
//  HistoryView.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import SwiftUI

struct HistoryView: View {
        
    // Custom
    @State private var viewModel = HistoryViewModel()
    
    // Environment
    @Environment(\.dismiss) private var dismiss
    
    // MARK: -
    var body: some View {
        List {
            ForEach(Array(viewModel.entriesByMonth).sorted(by: {
                $0.key.month ?? 0 > $1.key.month ?? 0
            }), id: \.key) { month, entries in
                Section {
                    ForEach(entries) { entry in
                        EntryCellView(entry: entry)
                    }
                } header: {
                    HStack {
                        Text(viewModel.monthYearString(from: month))
                            .foregroundStyle(Color.label)
                        Spacer()
                    }
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                }
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 6, leading: 16, bottom: 6, trailing: 16))
                .listRowBackground(Color.Apple.background.edgesIgnoringSafeArea(.all))
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(Color.Apple.background.ignoresSafeArea())
        .navigationTitle("Historique")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { dismiss() }, label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.label)
                })
            }
        }
        .task {
            await viewModel.sortEntriesByMonth()
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    NavigationStack {
        HistoryView()
    }
    .preferredColorScheme(.dark)
}
