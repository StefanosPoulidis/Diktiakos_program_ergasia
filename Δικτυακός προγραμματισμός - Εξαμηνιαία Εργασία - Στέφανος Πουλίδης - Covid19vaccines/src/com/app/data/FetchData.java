package com.app.data;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class FetchData
 */
@WebServlet("/FetchData")
public class FetchData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FetchData() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(true);
		String output = "";
		
		if(session.getAttribute("data") == null) {
			URL url = new URL("https://data.gov.gr/api/v1/query/mdg_emvolio");
			HttpURLConnection  connection = (HttpURLConnection) url.openConnection();
	        
	        connection.setRequestMethod("GET");
	        
	        connection.setRequestProperty("Content-Type", 
	            "application/jsonp");
	        connection.setRequestProperty("date_from", "2021-02-01");
	        connection.setRequestProperty("date_to", "2021-03-01");
	        connection.setRequestProperty("Authorization", "Token 8baff9ecebf9b6be353613c602ab165becc01276");
	        
	        BufferedReader in = new BufferedReader(
	                                new InputStreamReader(
	                                connection.getInputStream()));
	        String inputLine;
	         
	        while ((inputLine = in.readLine()) != null) 
	            output += inputLine;
	        in.close();
	        
	        session.setAttribute("data", output);
		} else {
			output = session.getAttribute("data").toString();
		}
		
		response.setContentType("application/json");  
        PrintWriter out=response.getWriter();  
        out.println(output);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
