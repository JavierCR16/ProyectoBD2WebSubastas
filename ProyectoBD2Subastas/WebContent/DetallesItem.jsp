<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "Gestores.GestorBD" %>    
<%@ page import= "java.util.*" %> 
<%@ page import = "Modelo.*" %>
<!DOCTYPE html>
<html>

<head> 
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="CSS/theme.css" type="text/css">
  </head>
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script type="text/javascript" src="Javascript/imagen.js"></script>

  <%
  	HttpSession sesionActual = request.getSession();
	Item itemInformacion = (Item)sesionActual.getAttribute("item");
	%>
  
<body>
  <nav class="navbar navbar-expand-md bg-primary navbar-dark bg-gradient">
    <div class="container">
      <a class="navbar-brand" href="#">Detalles del Ítem
        <br> </a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbar2SupportedContent" aria-controls="navbar2SupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
      <div class="collapse navbar-collapse text-center justify-content-end" id="navbar2SupportedContent"> </div>
    </div>
  </nav>
  <div class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h1 class="text-center">Detalles de Objeto
            <br> </h1>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="row">
            <div class="col-md-12">
              <p class="lead">ID del Ítem: <%= itemInformacion.getId() %></p>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <p class="lead">Descripción</p>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <p class=""><%= itemInformacion.getDescripcion()%> </p>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <p class="lead">Detalles de Entrega</p>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <p class=""><%= itemInformacion.getDetallesEntrega() %> </p>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="row">
            <div class="col-md-12">
              <p class="lead">Imagen</p>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
            
              <div id="divImagen">
              
              	<img src="C:/Users/Javier/git/ProyectoBD2WebSubastas/ProyectoBD2Subastas/src/Imagenes/<%=itemInformacion.getNombreImagen()%>">
              
              </div>
              
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <p class="lead">Precio Base: <%= itemInformacion.getPrecioBase()%></p>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <p class="lead">Inicio: <%= itemInformacion.getInicioSubasta() %></p>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <p class="lead">Fin: <%= itemInformacion.getFinSubasta() %></p>
            </div>
          </div>
          <div class="row d-flex justify-content-end">
            <button class="btn btn-primary" name="botonSubasta" type="submit"> Cerrar</button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" crossorigin="anonymous" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" crossorigin="anonymous" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"></script>
  <pingendo onclick="window.open('https://pingendo.com/', '_blank')" style="cursor:pointer;position: fixed;bottom: 10px;right:10px;padding:4px;background-color: #00b0eb;border-radius: 8px; width:180px;display:flex;flex-direction:row;align-items:center;justify-content:center;font-size:14px;color:white">Made with Pingendo&nbsp;&nbsp;
    <img src="https://pingendo.com/site-assets/Pingendo_logo_big.png" class="d-block" alt="Pingendo logo" height="16">
  </pingendo>
</body>

</html>