package com.example.ecommerce.store;
import com.example.ecommerce.model.Product; import java.math.BigDecimal; import java.util.*;
public class ProductRepository { private static final Map<String,Product> PRODUCTS=new LinkedHashMap<>();
static{ add(new Product("1001","Wireless Mouse","Ergonomic 2.4GHz wireless mouse",new BigDecimal("19.99")));
add(new Product("1002","Mechanical Keyboard","Backlit mechanical keyboard (Blue switches)",new BigDecimal("59.99")));
add(new Product("1003","USB-C Hub","7-in-1 USB-C hub with HDMI",new BigDecimal("34.50")));
add(new Product("1004","Noise-Canceling Headphones","Over-ear ANC headphones",new BigDecimal("89.00")));
add(new Product("1005","1080p Webcam","Full HD webcam with mic",new BigDecimal("39.95"))); }
private static void add(Product p){PRODUCTS.put(p.getId(),p);} public static List<Product> findAll(){return new ArrayList<>(PRODUCTS.values());}
public static Optional<Product> findById(String id){return Optional.ofNullable(PRODUCTS.get(id));} }