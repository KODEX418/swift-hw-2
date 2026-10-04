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
                let subtext = item.category != Category.Null ? "\(item.category.name) · \(item.quantity) шт" : "\(item.quantity) шт"
                Text(subtext)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .foregroundStyle(item.category.color)
            }
        }
    }
}

#Preview {
    ShoppingItemRow(item: ShoppingItem.samples[0], onToggle: {})
}
