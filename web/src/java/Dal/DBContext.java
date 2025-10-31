/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
     
    private static String serverName = "localhost";
    private static        String portNumber = "1433";
    private static        String databaseName = "Q3_L1_DB"; // Tên DB đã tạo ở bước 1
    private static        String USER = "sa"; // User SQL Server
    private static        String PASSWORD = "123"; // Password SQL Server
    private static String URL = "jdbc:sqlserver://" + serverName + ":" + portNumber + 
                         ";databaseName=" + databaseName + ";encrypt=true;trustServerCertificate=true";
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("SQLServer JDBC Driver not found.", e);
        }
    }
}