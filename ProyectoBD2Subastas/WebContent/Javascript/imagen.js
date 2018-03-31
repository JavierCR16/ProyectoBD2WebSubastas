function mostrarImagen(event){
    if(document.getElementById("imagenTag")!=null)
        $("#imagenTag").remove();
    
    var divImagen = document.getElementById("divImagen");
    var selectedFile = event.target.files[0];
    var reader = new FileReader();
    
    
    var pathImagen = document.getElementById("fileChooser");
    var elem = document.createElement("img");
    elem.width= 200;
    elem.height =200;
    elem.setAttribute("id","imagenTag");
    
    reader.onload = function(event){
         elem.src = event.target.result;
        
    }
    reader.readAsDataURL(selectedFile);
   
    divImagen.appendChild(elem);
    
}