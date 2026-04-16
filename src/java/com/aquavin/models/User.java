package com.aquavin.models;

public class User {
    // Ginawa nating public para madaling ma-access ng Servlets mo
    public String fullName, address, contact, username, password, email; 
    public String profilePic; 
    public boolean isNewUser = true;

    // Constructor
    public User(String fullName, String address, String contact, String username, String password, String email) {
        this.fullName = fullName;
        this.address = address;
        this.contact = contact;
        this.username = username;
        this.password = password;
        this.email = email;
        this.profilePic = "default-avatar.png"; // Default value
    }

    public void setNewUser(boolean isNew) {
        this.isNewUser = isNew;
    }

    // Getters and Setters
    public String getEmail() { return email; }
    public String getUsername() { return username; }
    public String getPassword() { return password; }
    
    public String getProfilePic() { 
        // Siguraduhin na hindi null ang ibabalik para hindi mag-error ang JSP
        return (profilePic == null || profilePic.isEmpty()) ? "default-avatar.png" : profilePic; 
    }
    
    public void setProfilePic(String profilePic) { 
        this.profilePic = profilePic; 
    }
}