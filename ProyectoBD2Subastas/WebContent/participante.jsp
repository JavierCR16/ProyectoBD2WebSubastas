<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import= "Gestores.GestorBD" %>    
<%@ page import= "java.util.*" %> 
<%@ page import = "Modelo.*" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="CSS/theme.css" type="text/css"> </head>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script type="text/javascript" src="Javascript/imagen.js"></script> 
    
  <script>
            $(document).ready(function () {
                $("#fileChooser").change(function () {
                    mostrarImagen(event);
                });
            });
  </script>
	
	
	
	<%
	
	HttpSession laSesion = request.getSession();
	GestorBD gestorParticipante = (GestorBD)laSesion.getAttribute("gestorParticipante");
	ArrayList<String> categorias = gestorParticipante.getCategorias();
	ArrayList<String> subCategorias = (ArrayList<String>) laSesion.getAttribute("subCatego");
	ArrayList<Subasta> subastasTotales = gestorParticipante.getSubastasSinRestriccion();
	ArrayList<Puja> pujasObtenidas = (ArrayList<Puja>)laSesion.getAttribute("pujasObtenidas");
	
	pujasObtenidas = (pujasObtenidas == null ? new ArrayList<>() : pujasObtenidas);
	subCategorias = (subCategorias == null ? new ArrayList<>() : subCategorias);
	
	//Aqui los datos de una subasta
		String tiempoInicioSubasta = (String)laSesion.getAttribute("tiempoInicioSubasta");
		String fechaInicioSubasta = (String)laSesion.getAttribute("fechaInicioSubasta");		
		String tiempoFinSubasta = (String)laSesion.getAttribute("tiempoFinSubasta");
		String fechaFinSubasta = (String)laSesion.getAttribute("fechaFinSubasta");		
		String descripcion = (String)laSesion.getAttribute("descripcion");
		String detalles = (String)laSesion.getAttribute("detalles");
		String precioBase = (String)laSesion.getAttribute("precioBase");
		
		tiempoInicioSubasta= (tiempoInicioSubasta == null? "":tiempoInicioSubasta);
		fechaInicioSubasta= (fechaInicioSubasta == null? "":fechaInicioSubasta);
		tiempoFinSubasta= (tiempoFinSubasta == null? "":tiempoFinSubasta);
		fechaFinSubasta= (fechaFinSubasta == null? "":fechaFinSubasta);
		descripcion = (descripcion == null ? "": descripcion);
		detalles = (detalles == null ? "": detalles);
		precioBase = (precioBase == null ? "": precioBase);
		
	
	//Aqui los datos de una subasta
	%>
	 

<body>
  <nav class="navbar navbar-expand-md bg-primary navbar-dark bg-gradient">
    <div class="container">
      <a class="navbar-brand" href="#">Sistema de Subastas
        <br> </a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbar2SupportedContent" aria-controls="navbar2SupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
      <div class="collapse navbar-collapse text-center justify-content-end" id="navbar2SupportedContent"> </div>
    </div>
  </nav>
  <div class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <ul class="nav nav-tabs">
            <li class="nav-item">
              <a href="" class="active nav-link" data-toggle="tab" data-target="#tabone">Vendedor
                <br> </a>
            </li>
            <li class="nav-item">
              <a href="" class="nav-link" data-toggle="tab" data-target="#tabtwo">Comprador
                <br> </a>
            </li>
            <li class="nav-item">
              <a href="" class="nav-link" data-toggle="tab" data-target="#tabthree">Consultas
                <br> </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#" data-toggle="tab" data-target="#tabfour">Usuarios
                <br> </a>
            </li>
          </ul>
          <form action="ServletParticipante" method = POST>
          <div class="tab-content mt-2">
            <div class="tab-pane fade show active" id="tabone" role="tabpanel">
              <h1 class="text-center">Subastar un Õçtem</h1>
              <form class="form-control">
                <div class="custom-control-inline">
                  <div class="input-group"> <label style = "margin-top: 10px">Inicio de Subasta:</label>
                  
                    <input value = '<%= fechaInicioSubasta %>' class="form-control" style="margin-left:5%; width:22%" type="date" name="fechaInicioSubasta">
                    <input value = '<%= tiempoInicioSubasta %>' type="time" class="form-control" style="margin-left:2%" name="horaInicioSubasta"> </div>
                    
            
                  <div class="input-group">
                  
                    <label style="margin-left: 5%; margin-top:10px;">Fin de Subasta:</label>
                    <input value = '<%= fechaFinSubasta %>' style="margin-left:5%; width:22%" type="date" class="form-control" name="fechaFinSubasta">
                    <input value = '<%= tiempoFinSubasta %>' style="margin-left: 2%" type="time" class="form-control" name="horaFinSubasta"> 
                    
                    </div>
                </div>
                  
                  <table>
                        <tbody> 
                        
                            <tr>
                                <td>Descripcion del Producto </td>
                                <td>Imagen del Producto</td>
                            </tr>
                                
                            <tr>
                                <td> <textarea class="form-control" rows="4" cols="50" name="descripcion" > <%= descripcion %> </textarea> </td> 
                            </tr>
                            
                            <tr>
                                <td>Detalles de Entrega </td>
                                <td>
                                        <div id="divImagen">

                                        </div>
                                </td>
                            </tr>
                                
                            <tr>
                                <td> <textarea class="form-control" rows="4" cols="50" name="detalles" > <%=detalles%> </textarea> </td>
                                <td><input name="fileChooser" id="fileChooser" type="file"/></td>
                            </tr>
                            
                            <tr>
                                <td>Precio Base </td>
                                <td>CategorÌa</td>
                            </tr>
                                
                            <tr>

                                <td> <input name="precio" type = "text" style = "border-radius: 10px" value = "<%=precioBase%>" >  </td>
                                <td> <select name= "comboCategorias" onchange ="this.form.submit()"> 
                                
                                <option value = "Categoria">CategorÌa</option>>
                                	<% for(int i =0;i<categorias.size(); i++){  %>
                                        	<option value="<%=categorias.get(i) %>"><%=categorias.get(i)%></option>
                                        	
                                        	<%} %>
                                        
                                    </select> </td>
                            </tr>
                            
                            <tr>
                                <td></td>
                                <td>SubCategorÌa</td>
                            </tr>
                            
                            <tr> 
                                <td></td>
                                <td><select name="subcategoria"> 
                                        <% for(int i =0;i<subCategorias.size(); i++){  %>
                                        	<option value="<%=subCategorias.get(i) %>"><%=subCategorias.get(i)%></option>
                                        	
                                        	<%} %>
                                        
                                    </select> </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <button class="btn btn-primary" name="botonSubasta" type ="submit" > Crear Subasta </button>
                                </td>
                                
                            </tr>
                            
                            
                            
                        </tbody>
                        
                    </table>
                  
              </form>
                
                
            </div>
           
            <div class="tab-pane fade" id="tabtwo" role="tabpanel">
              <p class="">Contenido de Comprador</p>
              
              
              
            </div>
            
            <div class="tab-pane fade" id="tabthree" role="tabpanel">
              <h1 class="text-center">Historial de Pujas</h1>
              	
              	<label>Subastas</label>
              	
              	 <table class="table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Vendedor</th>
                <th>Precio Base</th>
                <th>SubCategorÌa</th>
              </tr>
            </thead>
            <tbody>
            
             <%
             for(int i =0; i< subastasTotales.size();i++){	
             %>
             <tr>
             	<td> <%=subastasTotales.get(i).getId() %></td>
             	<td><%=subastasTotales.get(i).getVendedor() %></td>
             	<td><%=subastasTotales.get(i).getPrecioBase() %></td>
             	<td><%=subastasTotales.get(i).getSubCategoria() %></td>
             </tr>
             <%}%>
            </tbody>
          </table>

			<button name="botonActualizarSubastas"  class="btn btn-primary" > Actualizar Subastas </button> 
			
			<label>Pujas</label>
			
			<table class="table"> 
				<thead>
					<tr>
						<th>ID</th>
						<th>Comprador</th>
						<th>Fecha y Hora</th>
						<th>Monto Ofrecido</th>
					</tr>
				</thead>
				
				<tbody>
					<%
             			for(int i =0; i< pujasObtenidas.size();i++){	
            			 %>
             		<tr>
             			<td> <%=pujasObtenidas.get(i).getId() %></td>
             			<td><%=pujasObtenidas.get(i).getComprador() %></td>
             			<td><%=pujasObtenidas.get(i).getFechaHora() %></td>
             			<td><%=pujasObtenidas.get(i).getMonto() %></td>
            		 </tr>
             				<%}%>
				</tbody>
				
			</table>
			
			<label>Id Subasta</label>
			<input type = text name = "idSubasta" class="form-control">
			
			<button name="botonHistorialPujas"  class="btn btn-primary" >Mostrar Historial</button> 
			
            </div>
            
            <div class="tab-pane fade" role="tabpanel" id="tabfour">
              <p class="">Contenido de Usuarios</p>
            </div>
            
          </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <pingendo onclick="window.open('https://pingendo.com/', '_blank')" style="cursor:pointer;position: fixed;bottom: 10px;right:10px;padding:4px;background-color: #00b0eb;border-radius: 8px; width:180px;display:flex;flex-direction:row;align-items:center;justify-content:center;font-size:14px;color:white">Made with Pingendo&nbsp;&nbsp;
    <img src="https://pingendo.com/site-assets/Pingendo_logo_big.png" class="d-block" alt="Pingendo logo" height="16">
  </pingendo>
</body>

</html>