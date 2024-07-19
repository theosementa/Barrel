//
//  EntryCellView.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import SwiftUI

struct EntryCellView: View {
    
    // Builder
    @ObservedObject var entry: EntryEntity
    
    // Environment
    @Environment(\.managedObjectContext) private var viewContext
    
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
                    let litres = entry.litres.formatWith(num: 2) + "L"
                    Text(price + " / " + litres)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    
                    Spacer()
                    
                    Text(entry.priceOfLitre.formatWith(num: 2) + "€ / L")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color(uiColor: .lightGray))
                }
                
                HStack {
                    Text(entry.mileage.formatted() + " KM")
                    
                    Spacer()
                    
                    if !entry.isFault {
                        Text(entry.date.formatted(date: .numeric, time: .omitted))
                            .foregroundStyle(Color(uiColor: .lightGray))
                    }
                }
                .font(.system(size: 16, weight: .medium, design: .rounded))
            }
        }
        .backgroundComponent()
        .contextMenu {
            Button(role: .destructive, action: {
                DispatchQueue.main.async {
                    viewContext.delete(entry)
                    EntryManager.shared.fetchEntries()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        try? viewContext.save()
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
    EntryCellView(entry: EntryEntity.preview)
        .preferredColorScheme(.dark)
        .padding()
}
