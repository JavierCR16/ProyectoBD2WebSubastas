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
import Modelo.Comentario;
import Modelo.ConsultasHistorial;
import Modelo.Item;
import Modelo.Puja;
import Modelo.Subasta;

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
		boolean otraVentana = false;
		
		if(request.getParameter("botonSubasta") != null) {
			insertarSubasta(request);
			setNullParametrosViejos(request); // Para que cuando se borre la subasta no queden sus valores viejos.
			entroAOtro = true;
		}
		if(request.getParameter("botonPujar") !=null) {
			insertarPuja(request);
			entroAOtro = true;
		}
		if(request.getParameter("botonActualizarSubastas") !=null) {
			entroAOtro = true;
		}
		
		if(request.getParameter("botonHistorialPujas") != null) {
			entroAOtro = true;
			obtenerPujas(request);
		}
		
		if(request.getParameter("botonActualizarUsuarios") != null) {
			entroAOtro = true;
		}
		
		if(request.getParameter("botonMostrarDetallesComprador") != null) {
			entroAOtro = true;
			otraVentana = true;
			
			String idSubasta = request.getParameter("idSubastaComprador");
			
			pasarInfoItem(request, idSubasta);
			response.sendRedirect("DetallesItem.jsp");
			
		}
		
		if(request.getParameter("botonHistorialUsuarios") != null) {
			entroAOtro = true;
			String valorRadio = request.getParameter("radioBoton");
			String usuarioSeleccionado = request.getParameter("usuariosConsulta");
			
			if(valorRadio.equals("1"))
				obtenerMultiplesArreglos(request,"Vendedor",usuarioSeleccionado);
			else
				obtenerMultiplesArreglos(request,"Comprador",usuarioSeleccionado);
		}
		
		if(request.getParameter("botonSinFiltroComprador") != null) {
			entroAOtro = true;
			obtenerSubastasValidas(request);
		}
		
		
		if(request.getParameter("botonFiltrarComprador")!= null) {
			entroAOtro = true;
			obtenerSubastasFiltradas(request);
		}
		
		if(request.getParameter("botonVerDetallesConsultas") != null) {
			entroAOtro = true;
			otraVentana = true;
			
			String idSubasta = request.getParameter("idSubastaConsultas");
			
			pasarInfoItem(request, idSubasta);
			response.sendRedirect("DetallesItem.jsp");
		}
		
		if(!entroAOtro && request.getParameter("comboCategorias") != null) {
			if(!request.getParameter("comboCategorias").equals("Categoria")) { // Significa que el que se toco fue el de los filtros
				enviarParametrosASesion(request); //Esto para que cuando agarre las subcategorias se queden los campos que tenian algo escrito
			
				obtenerSubCategorias(request);
			}
			else {
				obtenerSubCategoriasFiltro(request);
			}
	
		}
		
		
			if(!otraVentana)
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

	private void obtenerSubCategoriasFiltro(HttpServletRequest request) {
		HttpSession sesionActual = request.getSession();
		GestorBD gestorParticipante = (GestorBD) sesionActual.getAttribute("gestorParticipante");
		int idCategoria = Integer.parseInt(request.getParameter("comboCategoriasFiltro").substring(0,request.getParameter("comboCategoriasFiltro").indexOf("-")));
		
		sesionActual.setAttribute("subCategoFiltro", gestorParticipante.filtrarSubCategorias(idCategoria));
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
		
		int idSubasta = Integer.parseInt(request.getParameter("idSubastaConsultas"));
		ArrayList<Puja> pujasObtenidas = gestorParticipante.getPujas(idSubasta); 
		
		laSesion.setAttribute("pujasObtenidas", pujasObtenidas);
	}

	private void obtenerMultiplesArreglos(HttpServletRequest request,String modalidadComentario,String usuarioSeleccionado) {
		HttpSession sesionActual = request.getSession();
		GestorBD gestorParticipante = (GestorBD) sesionActual.getAttribute("gestorParticipante");
		
		switch(modalidadComentario) {
		
			case "Vendedor":
		
				ArrayList<ConsultasHistorial> consultasObtenidasSubastas = gestorParticipante.obtenerHistorialSubastas(usuarioSeleccionado);
				ArrayList<Comentario> comentariosObtenidosVendedor = gestorParticipante.obtenerComentariosSobreUsuario(usuarioSeleccionado, "Vendedor");
				
				sesionActual.setAttribute("historialSubastas", consultasObtenidasSubastas);
				sesionActual.setAttribute("historialPujas", null);
				sesionActual.setAttribute("comentariosObtenidos", comentariosObtenidosVendedor);
				break;
		
			case "Comprador":
				ArrayList<ConsultasHistorial> consultasObtenidasPujas = gestorParticipante.obtenerHistorialPujas(usuarioSeleccionado);
				ArrayList<Comentario> comentariosObtenidosComprador = gestorParticipante.obtenerComentariosSobreUsuario(usuarioSeleccionado, "Comprador");
				
				sesionActual.setAttribute("historialPujas", consultasObtenidasPujas);
				sesionActual.setAttribute("historialSubastas", null);
				sesionActual.setAttribute("comentariosObtenidos", comentariosObtenidosComprador);
				break;
		}
	}

	private void obtenerSubastasFiltradas(HttpServletRequest request) {
		HttpSession sesionActual = request.getSession();
		GestorBD gestorParticipante = (GestorBD) sesionActual.getAttribute("gestorParticipante");
		String aliasParticipante = (String) sesionActual.getAttribute("aliasParticipante");
		String idSubCategoria = request.getParameter("subCategoriaFiltro").substring(0, request.getParameter("subCategoriaFiltro").indexOf("-"));
		
		ArrayList<Subasta> subastasFiltradas = gestorParticipante.getSubastasPorCategoria(new java.sql.Date(gestorParticipante.obtenerFecha().getTime()), aliasParticipante, Integer.parseInt(idSubCategoria),1);
		sesionActual.setAttribute("subastasValidas", subastasFiltradas);
	}

	private void obtenerSubastasValidas(HttpServletRequest request) {
		HttpSession sesionActual = request.getSession();
		GestorBD gestorParticipante = (GestorBD) sesionActual.getAttribute("gestorParticipante");
		String aliasParticipante = (String) sesionActual.getAttribute("aliasParticipante");
		
		ArrayList<Subasta> subastasValidasTotales = gestorParticipante.getSubastas(new java.sql.Date(gestorParticipante.obtenerFecha().getTime()), aliasParticipante);
		sesionActual.setAttribute("subastasValidas", subastasValidasTotales);
		
	}
	
	private void insertarPuja(HttpServletRequest request) {
		HttpSession sesionActual = request.getSession();
		GestorBD gestorParticipante = (GestorBD) sesionActual.getAttribute("gestorParticipante");
		String aliasParticipante = (String) sesionActual.getAttribute("aliasParticipante");
		
		int idSubasta = Integer.parseInt(request.getParameter("idSubastaComprador"));
		int idItem = gestorParticipante.buscarIdItem(idSubasta);
		
		BigDecimal montoOferta = new BigDecimal(request.getParameter("montoOferta"));
		
		Date fechaPuja = gestorParticipante.obtenerFecha();
		
		if(fechaPuja.before(gestorParticipante.obtenerTiempoFin(idSubasta))) {
			gestorParticipante.pujarPuja(aliasParticipante, idItem, montoOferta, new java.sql.Date(fechaPuja.getTime()));
		}else {
			System.out.println("Puja no insertada por fin de tiempo.");
		}
	}
	
	private void pasarInfoItem(HttpServletRequest request, String idSubasta) {
		HttpSession sesionActual = request.getSession();
		GestorBD gestorParticipante = (GestorBD) sesionActual.getAttribute("gestorParticipante");
		
		//String idSubasta = request.getParameter("idSubastaComprador");
		Item informacionItem = gestorParticipante.extraerInformacionItem(idSubasta);
		
		sesionActual.setAttribute("item", informacionItem);
	}
}
