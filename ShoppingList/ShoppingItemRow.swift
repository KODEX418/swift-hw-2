import SwiftUI

struct ShoppingItemRow: View {
    let item: ShoppingItem
    let onToggle: () -> Void
    var body: some View {
        HStack{
            Button(action: onToggle) {
                            Image(systemName: item.isPurchased
                                  ? "checkmark.circle.fill"
                                  : "circle")
                                .font(.title2)
                                .foregroundStyle(item.isPurchased ? .green : .secondary)
                        }
                        .buttonStyle(.plain)
            VStack(alignment: .leading){
                Text(item.name)
                    .font(Font.headline)
                    .bold()
                Text("\(item.category) · \(item.quantity) шт")
                    .font(.caption).foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    ShoppingItemRow(item: ShoppingItem.samples[0], onToggle: {})
}
