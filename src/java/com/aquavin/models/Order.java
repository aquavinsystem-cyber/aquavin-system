package com.aquavin.models;
import java.util.Date;

public class Order {
    public String customer, type, status;
    public int qty;
    public double total;
    public Date date;

    public Order(String customer, String type, int qty, double total, String status) {
        this.customer = customer;
        this.type = type;
        this.qty = qty;
        this.total = total;
        this.status = status;
        this.date = new Date();
    }
}