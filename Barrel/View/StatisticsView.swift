//
//  StatisticsView.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import SwiftUI

struct StatisticsView: View {
    
    // Custom
    @State private var viewModel = StatisticsViewModel()
    
    // Environment
    @Environment(\.dismiss) private var dismiss
        
    // MARK: -
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                CustomSegmentedControlView(
                    texts: ["\(viewModel.selectedViewModel?.comp.toMonth() ?? Date().month)", "\(Date().year)", "Total"],
                    selectedIndex: $viewModel.selectedTab
                )
                
                switch viewModel.selectedTab {
                case 0:
                    if let selectedViewModel = viewModel.selectedViewModel {
                        StatsOfTheCurrentMonthView(
                            viewModel: Binding<StatisticsForSelectedMonthViewModel>(
                                get: { selectedViewModel },
                                set: { viewModel.selectedViewModel = $0 }
                            )
                        )
                    } else {
                        StatsOfTheCurrentMonthView(
                            viewModel: Binding<StatisticsForSelectedMonthViewModel>(
                                get: {
                                    StatisticsForSelectedMonthViewModel(
                                        comp: Calendar.current.dateComponents([.year, .month], from: Date())
                                    )
                                },
                                set: { _ in }
                            )
                        )
                    }
                case 1:
                    StatsSummaryOfTheYearView()
                default:
                    StatsTotalView()
                }
                
            } // End VStack
            .padding()
        } // End ScrollView
        .scrollIndicators(.hidden)
        .navigationTitle("Statistiques")
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
            
            if viewModel.selectedTab == 0 {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        ForEach(viewModel.viewModels, id: \.self) { viewModel in
                            Button(action: {
                                withAnimation {
                                    self.viewModel.selectedViewModel = viewModel
                                }
                            }, label: {
                                Text(viewModel.comp.toMonthAndYear())
                            })
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Group {
                                if let selectedViewModel = viewModel.selectedViewModel {
                                    Text(selectedViewModel.comp.toMonthAndYear())
                                } else {
                                    Text(Date().toMonthAndYear())
                                }
                            }
                            .font(.system(size: 14, weight: .medium))
                            
                            Image(systemName: "chevron.up.chevron.down")
                                .font(.system(size: 10))
                        }
                        .foregroundStyle(Color.label)
                        .padding(6)
                        .padding(.horizontal, 4)
                        .backgroundComponent(radius: 8, isPaddingEnabled: false)
                    }
                }
            }
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    NavigationStack {
        StatisticsView()
            .preferredColorScheme(.dark)
            .padding(8)
    }
}
