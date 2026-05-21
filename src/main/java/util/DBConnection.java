package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // MySQL veritabanı adımız: ecommerce_db
    private static final String URL = "jdbc:mysql://localhost:3306/ecommerce_db?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
    
    private static final String USER = "root"; 
    private static final String PASSWORD = ""; 

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Veritabanı bağlantısı BAŞARILI!");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Veritabanı bağlantısı HATALI!");
            e.printStackTrace();
        }
        return connection;
    }
}