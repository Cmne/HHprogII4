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
	<title>Etätehtävät 6 HP</title>
</head>
<body>
	<div>
		<form id="tiedot">
			<table border="1"> <!-- class="table"? -->
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
						<td><input type="submit" id="tallenna" value="Hyväksy"></input></td>
					</tr>
				</tbody>
			</table>
			<input type="hidden" name="asiakas_id" id="asiakas_id"> <!-- was used for whichever purpose? -->
		</form>
		<p id="ilmo"></p>
	</div>
	<script>
		$(document).ready(function() {
			
			//moved following into $(document)
			var asiakas_id = requestURLParam("asiakas_id");
			//GET asiakkaat/haeyksi/asiakas_id // haeyksi indicates changed requirements of doGet method
			$.ajax({url:"asiakkaat/haeyksi/" + asiakas_id,
				type:"GET",
				dataType:"json",
				success:function(result) {
					$("#eNimi").val(result.etunimi);
					$("#sNimi").val(result.sukunimi);
					$("#puh").val(result.puhelin);
					$("#email").val(result.sposti);
					$("#asiakas_id").val(result.asiakas_id); //added the handling of hidden asiakas_id
				}
			});
			
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
					paivitaTiedot();
				}
			});
		});
		
		function paivitaTiedot() {
//			console.log("paivitaTiedot()");
			var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //found in scripts/main.js
			$.ajax({url:"asiakkaat",
				data:formJsonStr,
				type:"PUT",
				dataType:"json",
				success:function(result) { //joko {"response:1"} = onnistui tai {"response:0"} = epäonnistui
					if(result.response==0){
						$("#ilmo").html("Asiakkaan päivittäminen epäonnistui.");
					} else if (result.response==1) {
						$("#ilmo").html("Asiakkaan päivittäminen onnistui.");
						$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
					}
				}
			});
		}
	</script>
</body>
</html>