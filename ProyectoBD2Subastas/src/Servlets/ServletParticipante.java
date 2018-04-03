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
import Modelo.Puja;

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
		boolean entroAOtro = false;
		
		if(request.getParameter("botonSubasta") != null) {
			insertarSubasta(request);
			setNullParametrosViejos(request); // Para que cuando se borre la subasta no queden sus valores viejos.
			entroAOtro = true;
		}
		if(request.getParameter("botonActualizarSubastas") !=null) {
			entroAOtro = true;
		}
		
		if(request.getParameter("botonHistorialPujas") != null) {
			entroAOtro = true;
			obtenerPujas(request);
		}
		
		if(!entroAOtro && request.getParameter("comboCategorias") != null) {
			enviarParametrosASesion(request); //Esto para que cuando agarre las subcategorias se queden los campos que tenian algo escrito
			
			obtenerSubCategorias(request);
	
		}
		
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
			
			int idSubCategoria = Integer.parseInt(request.getParameter("subcategoria").substring(0, request.getParameter("subcategoria").indexOf("-"))); //Se debe cambiar por el metodo para obtener el id de categoria
			
			
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

	private void enviarParametrosASesion(HttpServletRequest request) {
		HttpSession sesionActual = request.getSession();
		String tiempoInicioSubasta = request.getParameter("horaInicioSubasta");
		String fechaInicioSubasta = request.getParameter("fechaInicioSubasta");		
		String tiempoFinSubasta = request.getParameter("horaFinSubasta");
		String fechaFinSubasta = request.getParameter("fechaFinSubasta");		
		String descripcion = request.getParameter("descripcion");
		String detalles = request.getParameter("detalles");
		String precioBase = request.getParameter("precio");
		
		sesionActual.setAttribute("tiempoInicioSubasta",tiempoInicioSubasta );
		sesionActual.setAttribute("fechaInicioSubasta",fechaInicioSubasta );
		sesionActual.setAttribute("tiempoFinSubasta", tiempoFinSubasta);
		sesionActual.setAttribute("fechaFinSubasta",fechaFinSubasta);
		sesionActual.setAttribute("descripcion",descripcion);
		sesionActual.setAttribute("detalles", detalles);
		sesionActual.setAttribute("precioBase",precioBase);
		
		
	}

	private void obtenerSubCategorias(HttpServletRequest request) {
		HttpSession sesionActual = request.getSession();
		GestorBD gestorParticipante = (GestorBD) sesionActual.getAttribute("gestorParticipante");
		int idCategoria = Integer.parseInt(request.getParameter("comboCategorias").substring(0,request.getParameter("comboCategorias").indexOf("-")));
		
		sesionActual.setAttribute("subCatego", gestorParticipante.filtrarSubCategorias(idCategoria));
	}

	private void setNullParametrosViejos(HttpServletRequest request) {
		HttpSession sesion = request.getSession();
		
		sesion.setAttribute("tiempoInicioSubasta",null);
		sesion.setAttribute("fechaInicioSubasta",null);
		sesion.setAttribute("tiempoFinSubasta",null);
		sesion.setAttribute("fechaFinSubasta",null);
		sesion.setAttribute("descripcion",null);
		sesion.setAttribute("detalles", null);
		sesion.setAttribute("precioBase",null);
		sesion.setAttribute("subCatego",null);
	}

	private void obtenerPujas(HttpServletRequest request) {
		HttpSession laSesion = request.getSession();
		GestorBD gestorParticipante = (GestorBD) laSesion.getAttribute("gestorParticipante");
		
		int idSubasta = Integer.parseInt(request.getParameter("idSubasta"));
		ArrayList<Puja> pujasObtenidas = gestorParticipante.getPujas(idSubasta); 
		
		laSesion.setAttribute("pujasObtenidas", pujasObtenidas);
	}
}
