package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import Gestores.GestorBD;

/**
 * Servlet implementation class ServletParticipante
 */
@WebServlet("/ServletParticipante")
public class ServletParticipante extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletParticipante() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		insertarSubasta(request);
		response.sendRedirect("participante.jsp");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	private void insertarSubasta(HttpServletRequest request) {
		HttpSession sesionActual = request.getSession();
		GestorBD gestorParticipante = (GestorBD) sesionActual.getAttribute("gestorParticipante");
		String aliasParticipante = (String) sesionActual.getAttribute("aliasParticipante");
		
		DateFormat formatoFechas = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.ENGLISH);
		try {
			String tiempoInicioSubasta = request.getParameter("horaInicioSubasta");
			String fechaInicioSubasta = request.getParameter("fechaInicioSubasta");
			Date dateInicio = formatoFechas.parse(fechaInicioSubasta + " " + tiempoInicioSubasta);
			
			String tiempoFinSubasta = request.getParameter("horaFinSubasta");
			String fechaFinSubasta = request.getParameter("fechaFinSubasta");
			Date dateFin = formatoFechas.parse(fechaFinSubasta + " " + tiempoFinSubasta);
			
			String descripcion = request.getParameter("descripcion");
			String detalles = request.getParameter("detalles");
			String imagen = request.getParameter("fileChooser");
			BigDecimal precioBase = new BigDecimal(request.getParameter("precio"));
			
			int idSubCategoria = 8000; //Se debe cambiar por el metodo para obtener el id de categoria
			
			
			gestorParticipante.crearSubasta(
                    aliasParticipante,
                    new java.sql.Date(dateInicio.getTime()),
                    new java.sql.Date(dateFin.getTime()),
                    descripcion,
                    imagen,
                    precioBase,
                    detalles,
                    idSubCategoria
            );
			
			
		} catch(ParseException e){
			e.printStackTrace();
		}
	}

}
