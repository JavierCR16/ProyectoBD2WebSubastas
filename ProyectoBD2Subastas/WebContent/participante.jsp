<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import= "Gestores.GestorBD" %>    
<%@ page import= "java.util.*" %> 
<%@ page import = "Modelo.*" %>
<%@ page import = "java.sql.Date" %>
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
	String aliasParticipante = (String) laSesion.getAttribute("aliasParticipante");
	ArrayList<String> categorias = gestorParticipante.getCategorias();
	ArrayList<String> subCategorias = (ArrayList<String>) laSesion.getAttribute("subCatego");
	ArrayList<String> subCategoriasFiltro = (ArrayList<String>) laSesion.getAttribute("subCategoFiltro");
	
	ArrayList<Subasta> subastasValidas = (ArrayList<Subasta>)laSesion.getAttribute("subastasValidas");
	ArrayList<Subasta> subastasTotales = gestorParticipante.getSubastasSinRestriccion();
	ArrayList<Puja> pujasObtenidas = (ArrayList<Puja>)laSesion.getAttribute("pujasObtenidas");
	ArrayList<String> usuarios = gestorParticipante.devolverUsuarios("NA", 0);
	ArrayList<ConsultasHistorial> historialSubastas = (ArrayList<ConsultasHistorial>) laSesion.getAttribute("historialSubastas");
	ArrayList<ConsultasHistorial> historialPujas = (ArrayList<ConsultasHistorial>) laSesion.getAttribute("historialPujas");
	ArrayList<Comentario> comentariosObtenidos = (ArrayList<Comentario>) laSesion.getAttribute("comentariosObtenidos");
	
	pujasObtenidas = (pujasObtenidas == null ? new ArrayList<>() : pujasObtenidas);
	subCategorias = (subCategorias == null ? new ArrayList<>() : subCategorias);
	subCategoriasFiltro = (subCategoriasFiltro == null ? new ArrayList<>() : subCategoriasFiltro);
	historialSubastas =  (historialSubastas == null ? new ArrayList<>() : historialSubastas);
	historialPujas =  (historialPujas == null ? new ArrayList<>() : historialPujas);
	comentariosObtenidos =  (comentariosObtenidos == null ? new ArrayList<>() : comentariosObtenidos);
	subastasValidas = (subastasValidas == null ? new ArrayList<>() : subastasValidas);
	
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
              <h1 class="text-center">Subastar un Ítem</h1>
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
                                <td>Categoría</td>
                            </tr>
                                
                            <tr>

                                <td> <input name="precio" type = "text" style = "border-radius: 10px" value = "<%=precioBase%>" >  </td>
                                <td> <select class="m-2" name= "comboCategorias" onchange ="this.form.submit()"> 
                                
                                <option value = "Categoria">Categoría</option>
                                	<% for(int i =0;i<categorias.size(); i++){  %>
                                        	<option value="<%=categorias.get(i) %>"><%=categorias.get(i)%></option>
                                        	
                                        	<%} %>
                                        
                                    </select> </td>
                            </tr>
                            
                            <tr>
                                <td></td>
                                <td>SubCategoría</td>
                            </tr>
                            
                            <tr> 
                                <td></td>
                                <td><select class="m-2" name="subcategoria"> 
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
               <div class="row">
                              <div class="col-md-12"> 
                                <table class="table">
                                  <thead>
                                    <tr>
                                      <th>ID</th>
                                      <th>Vendedor</th>
                                      <th>Precio Base</th>
                                      <th>SubCategoría</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                  
                                  <%for(int i = 0; i< subastasValidas.size();i++){  %>
                                    <tr>
                                      <td> <%=subastasValidas.get(i).getId() %></td>
                                      <td><%=subastasValidas.get(i).getVendedor() %></td>
                                      <td><%=subastasValidas.get(i).getPrecioBase() %></td>
                                      <td><%=subastasValidas.get(i).getSubCategoria() %></td>
                                    </tr>
                                    <%} %>
                                    
                                  </tbody>
                                </table>
                              </div>
                            </div>
                            <div class="row">
                              <div class="col-md-12 d-flex justify-content-end">
                                <button class="btn btn-primary m-2" name="botonSinFiltroComprador" type="submit"> Sin Filtro </button>
                                <button class="btn btn-primary m-2" name="botonMostrarDetallesComprador" type="submit"> Mostrar Detalles </button>
                              </div>
                            </div>
                            <div class="row">
                              <div class="col-md-6">
                                <div class="row"> </div>
                                <div class="row">
                                  <div class="col-md-12">
                                    <p class="lead m-2"><b>Nueva Oferta</b></p>
                                  </div>
                                </div>
                                <div class="row">
                                  <div class="col-md-12"> </div>
                                </div>
                                <div class="row">
                                  <div class="col-md-12 d-flex">
                                    <h3 class="m-2">₡</h3>
                                    <input name="montoOferta" type="text" style="border-radius: 10px" value="<%=precioBase%>" class="m-2"> </div>
                                </div>
                                
                                <div class="row">
                                  <div class="col-md-12 d-flex">
                                    <h3 class="m-2">ID:</h3>
                                    <input name="idSubastaComprador" type="text" style="border-radius: 10px" class="m-2"> </div>
                                </div>
                                
                                <div class="row d-flex justify-content-start">
                                  <button class="btn btn-primary m-3" name="botonPujar" type="submit"> Crear Puja </button>
                                </div>
                                <div class="row"> </div>
                              </div>
                              <div class="col-md-6">
                                <div class="row">
                                  <div class="col-md-12 d-flex justify-content-start">
                                    <p class="lead"><b>Filtros</b></p>
                                  </div>
                                </div>
                                <div class="row">
                                  <div class="col-md-12 d-flex justify-content-start">
                                    <p class="m-2">Categoria:</p> 
                                    <select name= "comboCategoriasFiltro" onchange ="this.form.submit()" class="m-2" >
                                      	 <option value = "Categoria">Categoría</option>
                                	<% for(int i =0;i<categorias.size(); i++){  %>
                                        	<option value="<%=categorias.get(i) %>"><%=categorias.get(i)%></option>
                                        	
                                        	<%} %>
                                        
                                    </select> </div>
                                </div>
                                <div class="row d-flex justify-content-start">
                                  <p class="m-2">Subcategoria:</p> 
                                  <select name = "subCategoriaFiltro" class="m-2">
                                  
                                       <% for(int i =0;i<subCategoriasFiltro.size(); i++){  %>
                                        	<option value="<%=subCategoriasFiltro.get(i) %>"><%=subCategoriasFiltro.get(i)%></option>
                                        	
                                        	<%} %>
                                        	
                                    </select> </div>
                                <div class="row">
                                  <button class="btn btn-primary m-2" name="botonFiltrarComprador" type="submit"> Filtrar </button>
                                </div>
                              </div>
                            </div>
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
                <th>SubCategoría</th>
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
			
			<br>
            <br>
            <br>
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
			<input type = text name = "idSubasta">
			
			<br>
			<br>
			
			<button name="botonHistorialPujas"  class="btn btn-primary" >Mostrar Historial</button> 
			
            </div>
            
            <div class="tab-pane fade" role="tabpanel" id="tabfour">
            
            	 <div class="row">
                              <div class="col-md-12">
                                <h3 class="text-center" contenteditable="true">Historial de Usuarios</h3>
                              </div>
                            </div>
                            <div class="row">
                              <div class="col-md-6 d-flex justify-content-start"> <label style="margin-left: 15px">Usuario:</label> 
                              <select name = "usuariosConsulta" style="margin-left: 15px">  
                              
                              		<%
                              			for(int i =0; i<usuarios.size();i++){
                              		%>
                              		
                              		<option value="<%=usuarios.get(i) %>"><%=usuarios.get(i)%></option>
                              		
                              		<%} %>
                              		
                              
                                    
                                </select> </div>
                              <div class="col-md-6">
                                <div class="row">
                                  <div class="col-md-12 align-items-center d-flex justify-content-end flex-row">
                                  
                                    <input name="radioBoton" type="radio" value="1" checked> Ventas
                                    <input name="radioBoton" type="radio" value="2" style="margin-left: 10px"> Pujas (Ganadoras) 
                                    
                                   </div>
                                </div>
                              </div>
                            </div>
                            <div class="row">
                              <div class="col-md-12">
                                <table class="table">
                                  <thead>
                                    <tr>
                                      <th>Ítem</th>
                                      <th>Precio Base</th>
                                      <th>Precio Final</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                  
                                  
                                  <%
                                 

                                  for(int i = 0; i<historialSubastas.size(); i++){ %>
                                  
                                    <tr>
                                      <td> <%=historialSubastas.get(i).getDescripcionItem()  %> </td>
                                      <td><%=historialSubastas.get(i).getPrecioBase() %> </td>
                                      <td><%=historialSubastas.get(i).getPrecioFinal() %> </td>
                                    </tr>
                                    
                                  <%} 
                                  for(int j=0; j<historialPujas.size();j++){
                                  %>  
                                  	<tr>
                                      <td> <%=historialPujas.get(j).getDescripcionItem()  %> </td>
                                      <td><%=historialPujas.get(j).getPrecioBase() %> </td>
                                      <td><%=historialPujas.get(j).getPrecioFinal() %> </td>
                                    </tr>
                                  <%} %>
                                  
                                  </tbody>
                                </table>
                              </div>
                            </div>
                            <div class="row">
                              <div class="col-md-12"> </div>
                            </div>
                            <div class="row">
                              <div class="col-md-12">
                                <p class="lead">Comentarios</p>
                              </div>
                            </div>
                            <div class="row">
                              <div class="col-md-12">
                                <table class="table">
                                  <thead>
                                    <tr>
                                      <th>Autor</th>
                                      <th>Ítem</th>
                                      <th>Comentario</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                  
                                  <%for(int i =0; i<comentariosObtenidos.size();i++){ %>
                                    <tr>
                                      <td> <%=comentariosObtenidos.get(i).getAutor() %></td>
                                      <td><%=comentariosObtenidos.get(i).getItem() %></td>
                                      <td><%=comentariosObtenidos.get(i).getComentario()%></td>
                                    </tr>
                                    
                                    <%} %>
                                    
                                    
                                  </tbody>
                                </table>
                              </div>
                            </div>
                            
                            <div class="row">
                            <div class="col-md-12">
                              <button type = "submit" name="botonActualizarUsuarios" class="btn btn-primary">Actualizar</button>
                              <button type = "submit" name="botonHistorialUsuarios" class="btn btn-primary">Mostrar Historial</button>
                            </div>
                          </div>

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