<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="css/styles.css">
	<title>Etätehtävät 4 HP</title>
</head>
<body>
	<table id="listaus" border="1"> <!-- remove border -->
		<thead>
			<tr>
				<th colspan="5"><a href="lisaaasiakas.jsp">Lisää uusi asiakas</a></th>
			</tr>
			<tr>
				<th colspan="3" class="right">Hakusana:</th>
				<th><input type="text" id="hakusana"></th>
				<th><input type="button" value="Hae" id="hakunappi"></th>
			</tr>
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sähköposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<script>
		$(document).ready(function() {
			haeAsiakkaat();
			$("#hakunappi").click(function() {
				haeAsiakkaat();
			});
		});
		
		function haeAsiakkaat() {
			$("#listaus tbody").empty();
			$.ajax({url:"asiakkaat/" + $("#hakusana").val(),
					type:"GET",
					dataType:"json",
					success:function(result) {
				$.each(result.asiakkaat, function(i, field) {
					var htmlStr;
					htmlStr += "<tr id='rivi_" + field.asiakas_id + "'>";
					htmlStr += "<td>" + field.etunimi + "</td>";
					htmlStr += "<td>" + field.sukunimi + "</td>";
					htmlStr += "<td>" + field.puhelin + "</td>";
					htmlStr += "<td>" + field.sposti + "</td>";
					htmlStr += "<td><a class='button' href='muutaasiakas.jsp?asiakas_id=" + field.asiakas_id + "'>Muuta</a>&nbsp"
					htmlStr += "<input type='button' value='Poista' id='delete' onclick=poista('" + field.asiakas_id + "')></td>";
					htmlStr += "</tr>";
					$("#listaus tbody").append(htmlStr);
				});
			}});
		}
		
		function poista(asiakas_id) {
			if (confirm("Poista asiakas " + asiakas_id + "?")) {
				$.ajax({url: "asiakkaat/" + asiakas_id,
						type: "DELETE",
						dataType: "json",
						success: function(result) { //result on joko {"response:1"} tai {"response:0"}
							if (result.response==0) {
								alert("Poisto epäonnistui");
							} else if (result.response==1) {
								$("#rivi_" + asiakas_id).css("background-color", "red");
								alert("Poisto onnistui");
								haeAsiakkaat();
							}
						}
				});
			}
		}
	</script>
</body>
</html>