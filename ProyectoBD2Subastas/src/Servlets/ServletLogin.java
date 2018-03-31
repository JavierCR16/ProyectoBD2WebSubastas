package Servlets;

import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Gestores.GestorBD;

import javax.servlet.*;

/**
 * Servlet implementation class ServletLogin
 */
@WebServlet("/ServletLogin")
public class ServletLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    	
       
       
  
       // response.sendRedirect("divisas.jsp");
        	
        
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
    	
    	GestorBD gestorBase = new GestorBD();
    	
        HttpSession sesionActual = request.getSession();
        String aliasUsuario = request.getParameter("cuadroAlias");
        String contraUsuario = request.getParameter("cuadroContrasenna");
        
        if(gestorBase.existeConexionUsuarios(aliasUsuario, contraUsuario) && gestorBase.existeEntidad(aliasUsuario, "PARTICIPANTE")) {
        	gestorBase.establecerConexionUsuario(aliasUsuario, contraUsuario);
        	response.sendRedirect("participante.jsp");
        }
        else {
        	response.sendRedirect("login.jsp");
        	sesionActual.setAttribute("mensajeError", "No existe un usuario asociado a "+aliasUsuario);
        }
        		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
