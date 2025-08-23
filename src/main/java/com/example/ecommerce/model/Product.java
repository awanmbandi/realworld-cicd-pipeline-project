package com.example.ecommerce.model;
import java.math.BigDecimal; import java.util.Objects;
public class Product { private final String id,name,description; private final BigDecimal price;
public Product(String id,String name,String description,BigDecimal price){this.id=id;this.name=name;this.description=description;this.price=price;}
public String getId(){return id;} public String getName(){return name;} public String getDescription(){return description;} public BigDecimal getPrice(){return price;}
public boolean equals(Object o){if(this==o)return true; if(o==null||getClass()!=o.getClass())return false; Product p=(Product)o; return Objects.equals(id,p.id);} public int hashCode(){return Objects.hash(id);} }