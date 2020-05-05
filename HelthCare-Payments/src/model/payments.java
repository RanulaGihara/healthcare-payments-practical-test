package model;

import java.sql.*;

public class payments {

	public Connection connect() {
		Connection con = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/healthcare_app", "root", "");
			// For testing
			System.out.print("Successfully connected");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return con;

	}

	// insert method which insert data to payments table
	public String insertPayment(String payment_method, String amount, String date, String bank_name,
			String account_num) {
		String output = "";
		try {
			Connection con = connect();
			if (con == null) {
				return "Error while connecting to the database";
			}

			String query = " insert into payments(`id`,`payment_method`,`amount`,`date`,`bank_name`,`account_num`)"
					+ " values (?, ?, ?, ?, ?, ?)";
			PreparedStatement preparedStmt = con.prepareStatement(query);

			preparedStmt.setInt(1, 0);
			preparedStmt.setString(2, payment_method);
			preparedStmt.setString(3, amount);
			preparedStmt.setString(4, date);
			preparedStmt.setString(5, bank_name);
			preparedStmt.setString(6, account_num);

			preparedStmt.execute();
			con.close();
			
			String newItems = readItems();
			 output = "{\"status\":\"success\", \"data\": \"" +
			 newItems + "\"}"; 
			 
		} catch (Exception e) {
			output = "{\"status\":\"error\", \"data\":\"Error while inserting the item.\"}";  
			System.err.println(e.getMessage());
		}
		return output;
	}

	// View inserted data
	public String readItems() {
		String output = "";
		try {
			Connection con = connect();
			if (con == null) {
				return "Error while connecting to the database for reading.";
			}

			// displaying html table
			String query = "select * from payments";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);

			// iterate through the rows in the result set
			while (rs.next()) {
				String id = Integer.toString(rs.getInt("id"));
				String payment_method = rs.getString("payment_method");
				String amount = rs.getString("amount");
				String date = rs.getString("date");
				String bank_name = rs.getString("bank_name");
				String account_num = rs.getString("account_num");

				// Add into the html table
				output += "<tr><td><input id='hidItemIDUpdate'name='hidItemIDUpdate' type='hidden'value='" + id  + "'>" + payment_method + "</td>"; 
				output += "<td>" + amount + "</td>";
				output += "<td>" + date + "</td>";
				output += "<td>" + bank_name + "</td>";
				output += "<td>" + account_num + "</td>";

				// buttons
				output += "<td><input name='btnUpdate' type='button'value='Update'class='btnUpdate btn btn-secondary' data-toggle=\'modal\' data-target=\'#add\'></td><td><input name='btnRemove' type='button'value='Remove'class='btnRemove btn btn-danger' data-id='"
						+ id + "'>" + "</td></tr>";
			}
			con.close();
			// Complete the html table
			output += "</table>";
		} catch (Exception e) {
			output = "Error while reading the items.";
			System.err.println(e.getMessage());
		}
		return output;
	}

	// update payments table
	public String updatePayment(String id, String payment_method, String amount, String date, String bank_name,
			String account_num) {
		String output = "";
		try {
			Connection con = connect();
			if (con == null) {
				return "Error while connecting to the database for updating.";
			}

			String query = "UPDATE payments SET payment_method=?,amount=?,date=?,bank_name=?,account_num=? WHERE id=?";
			PreparedStatement preparedStmt = con.prepareStatement(query);

			preparedStmt.setString(1, payment_method);
			preparedStmt.setString(2, amount);
			preparedStmt.setString(3, date);
			preparedStmt.setString(4, bank_name);
			preparedStmt.setString(5, account_num);
			preparedStmt.setInt(6, Integer.parseInt(id));

			preparedStmt.execute();
			con.close();
			
			String newItems = readItems();
			 output = "{\"status\":\"success\", \"data\": \"" +
			 newItems + "\"}"; 
			 
		} catch (Exception e) {
			
			output = "{\"status\":\"error\", \"data\":\"Error while updating the item.\"}"; 
			System.err.println(e.getMessage());
		}
		return output;
	}

	// deleting table
	public String deleteItem(String id) {
		String output = "";
		try {
			Connection con = connect();
			if (con == null) {
				return "Error while connecting to the database for deleting.";
			}
			// create a prepared statement
			String query = "delete from payments where id=?";
			PreparedStatement preparedStmt = con.prepareStatement(query);
			// binding values
			preparedStmt.setInt(1, Integer.parseInt(id));
			// execute the statement
			preparedStmt.execute();
			con.close();

			String newItems = readItems();
			 output = "{\"status\":\"success\", \"data\": \"" +
			 newItems + "\"}";
			 
		} catch (Exception e) {
			e.printStackTrace();
		
			output = "{\"status\":\"error\", \"data\": \"Error while deleting the item.\"}"; 
			System.err.println(e.getMessage());
		}
		return output;
	}
}
