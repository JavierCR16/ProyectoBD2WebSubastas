<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import= "Gestores.GestorBD" %>    
<%@ page import= "java.util.*" %> 
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
          <div class="tab-content mt-2">
            <div class="tab-pane fade show active" id="tabone" role="tabpanel">
              <h1 class="text-center">Subastar un Ítem</h1>
              <form class="form-control">
                <div class="custom-control-inline">
                  <div class="input-group"> <label style = "margin-top: 10px">Inicio de Subasta:</label>
                    <input class="form-control" style="margin-left:5%; width:22%" type="date">
                    <input type="time" class="form-control" style="margin-left:2%"> </div>
                    
            
                  <div class="input-group">
                      <label style="margin-left: 5%; margin-top:10px;">Fin de Subasta:</label>
                    <input style="margin-left:5%; width:22%" type="date" class="form-control">
                    <input style="margin-left: 2%" type="time" class="form-control"> 
                    </div>
                </div>
                  
                  <table>
                        <tbody> 
                        
                            <tr>
                                <td>Descripcion del Producto </td>
                                <td>Imagen del Producto</td>
                            </tr>
                                
                            <tr>
                                <td> <textarea class="form-control" rows="4" cols="50" name="comment" form="usrform"> </textarea> </td>
                                
                            </tr>
                            
                            <tr>
                                <td>Detalles de Entrega </td>
                                <td>
                                        <div id="divImagen">

                                        </div>

                                </td>
                            </tr>
                                
                            <tr>
                                <td> <textarea class="form-control" rows="4" cols="50" name="comment" form="usrform"> </textarea> </td>
                                <td><input name="fileChooser" id="fileChooser" type="file"/></td>
                            </tr>
                            
                            <tr>
                                <td>Precio Base </td>
                                <td>Categoría</td>
                            </tr>
                                
                            <tr>
                                <td> <input type = "text" style = "border-radius: 10px " >  </td>
                                <td> <select> 
                                	<% for(int i =0;i<categorias.size(); i++){  %>
                                        	<option value="<%=categorias.get(i) %>">categorias.get(i)</option>
                                        	
                                        	<%} %>
                                        
                                    </select> </td>
                            </tr>
                            
                            <tr>
                                <td></td>
                                <td>SubCategoría</td>
                            </tr>
                            
                            <tr> 
                                <td></td>
                                
                                
                                <td><select> 
                                        <--> Se debe hacer una consulta de chava para las subcategorias</-->
                                        
                                    </select> </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <button type ="submit" > Crear Subasta </button>
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
              <p class="">Contenido de Consultas</p>
            </div>
            <div class="tab-pane fade" role="tabpanel" id="tabfour">
              <p class="">Contenido de Usuarios</p>
            </div>
          </div>
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