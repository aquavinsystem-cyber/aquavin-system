package com.aquavin.util;

import com.aquavin.models.*;
import java.util.*;

public class DataStore {
    private static DataStore instance;
    public List<User> users = new ArrayList<>();
    public List<Order> orders = new ArrayList<>();

    private DataStore() {
        // Default admin account for testing
        users.add(new User(
            "Admin User", 
            "Manila", 
            "09123456789", 
            "admin", 
            "Admin123!", 
            "admin@aquavin.com"
        ));
    }

    public static DataStore getInstance() {
        if (instance == null) {
            instance = new DataStore();
        }
        return instance;
    }
    
    // 1. Helper para mahanap ang user sa email (Para sa Forgot Password)
    public User findUserByEmail(String email) {
        for (User u : users) {
            if (u.email != null && u.email.equalsIgnoreCase(email)) {
                return u;
            }
        }
        return null;
    }

    // 2. ITO YUNG DINAGDAG KO: Helper para mahanap ang user sa Username
    // Gagamitin natin ito sa Login at Update Profile para hindi mawala ang data
    public User findUserByUsername(String username) {
        for (User u : users) {
            if (u.username != null && u.username.equalsIgnoreCase(username)) {
                return u;
            }
        }
        return null;
    }
}