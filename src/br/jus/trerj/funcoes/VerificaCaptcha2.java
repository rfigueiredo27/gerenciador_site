package br.jus.trerj.funcoes;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

public class VerificaCaptcha2 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String secretParameter="";
       
    public VerificaCaptcha2() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Get input parameter values (form data)
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String recap = request.getParameter("g-recaptcha-response");
        
        // Send get request to Google reCaptcha server with secret key  
        URL url = new URL("https://www.google.com/recaptcha/api/siteverify?secret="+secretParameter+"&response="+recap+"&remoteip="+request.getRemoteAddr());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        String line, outputString = "";
        BufferedReader reader = new BufferedReader(
                new InputStreamReader(conn.getInputStream()));
        while ((line = reader.readLine()) != null) {
            outputString += line;
        }
        System.out.println(outputString);
        
        // Convert response into Object
        CaptchaResponse capRes = new Gson().fromJson(outputString, CaptchaResponse.class);
        request.setAttribute("name", name);
        request.setAttribute("email", email);
        
        // Verify whether the input from Human or Robot 
        if(capRes.isSuccess()) {
            // Input by Human
            request.setAttribute("verified", "true");   
        } else {
            // Input by Robot
            request.setAttribute("verified", "false");
        }
        //request.getRequestDispatcher("/response.jsp").forward(request, response);
        //request.out.print(request.getAttribute("verified"));
    }

}