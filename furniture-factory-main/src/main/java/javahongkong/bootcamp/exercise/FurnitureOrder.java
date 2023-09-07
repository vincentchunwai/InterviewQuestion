package com.javahongkong.bootcamp.exercise;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Objects;
import java.util.Optional;

public class FurnitureOrder implements FurnitureOrderInterface {
    /**
     * TODO: Create a map of Furniture items to order quantities
     */
    HashMap<Furniture, Integer> ordersOfFurnitures;

    /**
     * Initialize a new mapping of Furniture types to order quantities.
     */
    FurnitureOrder() {
        // TODO: Complete the constructor
        ordersOfFurnitures = new HashMap<>();
    }

    public void addToOrder(final Furniture type, final int furnitureCount) {
        // TODO: Complete the method
        ordersOfFurnitures.put(type, furnitureCount);
    }

    public HashMap<Furniture, Integer> getOrderedFurniture() {
        // TODO: Complete the method
        return this.ordersOfFurnitures;
    }

    public float getTotalOrderCost() {
        // TODO: Complete the method
        /*
         * BigDecimal total1 = 0;
         * for (var entry:ordersOfFurnitures.entrySet()){
         * if(entry.getValue() != null)
         * total.add(BigDecimal.valueOf(entry.getValue()*entry.getKey().cost()));
         * }
         * return total1.floatValue();
         */
         float total = 0;
        for (var entry : ordersOfFurnitures.entrySet()) {
            if (Objects.nonNull(entry.getValue()))
                total += entry.getValue() * entry.getKey().cost();
        }
        return total;
    }

    public int getTypeCount(Furniture type) {
        // TODO: Complete the method

        return Optional.ofNullable(ordersOfFurnitures.get(type)).orElse(0);
    }

    public float getTypeCost(Furniture type) {
        // TODO: Complete the method
        if (Objects.nonNull(ordersOfFurnitures.get(type)))
            return ordersOfFurnitures.get(type) * type.cost();

        return 0;
    }

    public int getTotalOrderQuantity() {
        // TODO: Complete the method
        /* int total = 0;
        for (int num : ordersOfFurnitures.values()) {
            total += num;
        }

        return total; */
        return ordersOfFurnitures.values().stream().mapToInt(Integer::intValue).sum();
    }
}