<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<script src="scripts/main.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
	<link rel="stylesheet" type="text/css" href="css/styles.css">
	<title>Etätehtävät 5 HP</title>
</head>
<body>
	<div>
		<form id="tiedot">
			<table border="1">
				<thead>
					<tr>
						<th colspan="5"><a href="listaaasiakkaat.jsp">Takaisin listaukseen</a></th>
					</tr>
					<tr>
						<th>Etunimi</th>
						<th>Sukunimi</th>
						<th>Puhelin</th>
						<th>Sähköposti</th>
						<th></th> <!-- for buttons -->
					</tr>
				</thead>
				<tbody>
					<tr> <!-- note: name attribute required for validation -->
						<td><input type="text" name="etunimi" id="eNimi"></input></td>
						<td><input type="text" name="sukunimi" id="sNimi"></input></td>
						<td><input type="text" name="puhelin" id="puh"></input></td>
						<td><input type="text" name="sposti" id="email"></input></td>
						<td><input type="submit" id="tallenna" value="Lisää"></input></td>
					</tr>
				</tbody>
			</table>
		</form>
		<p id="ilmo"></p>
	</div>
	<script>
		$(document).ready(function() {
			$("#tiedot").validate({
				rules: {
					etunimi: {
						required: true,
						minlength: 2,
						maxlength: 20
					},
					sukunimi: {
						required: true,
						minlength: 2,
						maxlength: 30
					},
					puhelin: {
						required: true,
						minlength: 5,
						maxlength: 14
					},
					sposti: {
						required: true,
						email: true,
						minlength: 8,
						maxlength: 40
					}
				},
				messages: { //if invalid, what is user told
					etunimi: {
						required: "Puuttuu",
						minlength: "Liian lyhyt",
						maxlength: "Liian pitkä"
					},
					sukunimi: {
						required: "Puuttuu",
						minlength: "Liian lyhyt",
						maxlength: "Liian pitkä"
					},
					puhelin: {
						required: "Puuttuu",
						minlength: "Liian lyhyt",
						maxlength: "Liian pitkä"
					},
					sposti: {
						required: "Puuttuu",
						email: "Ei kelpaa",
						minlength: "Liian lyhyt",
						maxlength: "Liian pitkä"
					}
				},
				submitHandler: function(form) { //if valid
//					console.log("Valid"); //for testing purposes
					lisaaTiedot();
				}
			});	
		});
		
		function lisaaTiedot() {
//			console.log("lisaaTiedot()");
			var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
			$.ajax({url:"asiakkaat",
				data:formJsonStr,
				type:"POST",
				dataType:"json",
				success:function(result) { //joko {"response:1"} = onnistui tai {"response:0"} = epäonnistui
					if(result.response==0){
						$("#ilmo").html("Asiakkaan lisääminen epäonnistui.");
					} else if (result.response==1) {
						$("#ilmo").html("Asiakkaan lisääminen onnistui.");
						$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
					}
				}
			});
		}
	</script>
</body>
</html>