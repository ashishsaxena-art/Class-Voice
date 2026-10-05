package com.classvoice.dao;
import com.classvoice.model.User; import com.classvoice.util.DBConnection; import java.sql.*;
public class UserDAO {
 public User findByEmail(String email)throws SQLException{String sql="SELECT * FROM users WHERE email=?";try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql)){p.setString(1,email);try(ResultSet r=p.executeQuery()){return r.next()?map(r):null;}}}
 public long create(User u)throws SQLException{String sql="INSERT INTO users(name,email,password,role) VALUES(?,?,?,?)";try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)){p.setString(1,u.getName());p.setString(2,u.getEmail());p.setString(3,u.getPassword());p.setString(4,u.getRole());p.executeUpdate();try(ResultSet r=p.getGeneratedKeys()){if(r.next())return r.getLong(1);}}return -1;}
 private User map(ResultSet r)throws SQLException{User u=new User();u.setUserId(r.getLong("user_id"));u.setName(r.getString("name"));u.setEmail(r.getString("email"));u.setPassword(r.getString("password"));u.setRole(r.getString("role"));Timestamp t=r.getTimestamp("created_at");if(t!=null)u.setCreatedAt(t.toLocalDateTime());return u;}
}
