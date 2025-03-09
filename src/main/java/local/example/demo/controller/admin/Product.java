package local.example.demo.controller.admin;

public class Product {
    private int id;
    private String name;
    private String category;
    private String technology;
    private String description;
    private double price;
    private double discount;

    public Product(int id, String name, String category, String technology, String description, double price,
            double discount) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.technology = technology;
        this.description = description;
        this.price = price;
        this.discount = discount;
    }

    // Getters và Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getTechnology() {
        return technology;
    }

    public void setTechnology(String technology) {
        this.technology = technology;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }
}
