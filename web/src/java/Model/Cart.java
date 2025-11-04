package Model;

import java.util.*;

public class Cart {
    private Map<Integer, CartItem> items = new LinkedHashMap<>();

    public void addItem(Product product, int quantity) {
        if (items.containsKey(product.getProductID())) {
            CartItem item = items.get(product.getProductID());
            item.setQuantity(item.getQuantity() + quantity);
        } else {
            items.put(product.getProductID(), new CartItem(product, quantity));
        }
    }

    public void removeItem(int productId) {
        items.remove(productId);
    }

    public double getTotal() {
        double sum = 0;
        for (CartItem item : items.values()) {
            sum += item.getTotalPrice();
        }
        return sum;
    }

    public Collection<CartItem> getItems() {
        return items.values();
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public void clear() {
        items.clear();
    }
}
