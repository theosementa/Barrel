//
//  EntryCellView.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import SwiftUI

struct EntryCellView: View {
    
    // Builder
    @ObservedObject var entry: EntryResponse
    
    // Environment
    @EnvironmentObject private var entryRepo: EntryRepository
    
    // MARK: -
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "fuelpump.fill")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.customYellow)
                .frame(width: 40, height: 40)
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.Apple.componentInComponent)
                }
            
            VStack(spacing: 6) {
                HStack(alignment: .bottom) {
                    let price = entry.price.formatWith(num: 2) + "€"
                    if let liters = entry.liters {
                        let litres = liters.formatWith(num: 2) + "L"
                        Text(price + " / " + litres)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                    }
                    
                    Spacer()
                    
                    Text(entry.priceOfLitre.formatWith(num: 2) + "€ / L")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color(uiColor: .lightGray))
                }
                
                HStack {
                    Text(entry.mileage.formatted() + " KM")
                    
                    Spacer()
                    
                    Text(entry.dateIso.isoToDateString() ?? "")
                        .foregroundStyle(Color(uiColor: .lightGray))
                }
                .font(.system(size: 16, weight: .medium, design: .rounded))
            }
        }
        .backgroundComponent()
        .contextMenu {
            Button(role: .destructive, action: {
                Task {
                    if let entryID = entry.id {
                        await entryRepo.deleteEntry(entryID: entryID)
                    }
                }
            }, label: {
                Label("Supprimer", systemImage: "trash.fill")
            })
        } preview: {
            self
                .frame(width: UIScreen.main.bounds.width - 32)
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    EntryCellView(entry: EntryResponse.preview)
        .preferredColorScheme(.dark)
        .padding()
}
