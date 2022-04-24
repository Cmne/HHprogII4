<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<title>Etätehtävät 4 HP</title>
	<style>
		table {
			border-collapse: collapse;
		}
		th {
			height: 40px;
			text-align: left;
			background-color: #24a824;
			color: white;
		}
		th, td {
			padding: 5px;
		}
		tr:nth-child(even) {
			background-color: #d9d9d9;
		}
		.right {
			text-align: right;
		}
		.left {
			text-align: left;
		}
	</style>
</head>
<body>
	<table id="listaus" border="1"> <!-- remove border -->
		<thead>
			<tr>
				<th colspan="2" class="right">Hakusana:</th>
				<th><input type="text" id="hakusana"></th>
				<th><input type="button" value="Hae" id="hakunappi"></th>
			</tr>
			<tr>
<!--				<th>Asiakas_id</th> <!-- commented out for styling -->
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sähköposti</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<script>
		$(document).ready(function() {
			haeAsiakkaat();
			$("#hakunappi").click(function() {
//				console.log($("#hakusana").val()); //for testing purposes
				haeAsiakkaat();
			});
		});
		
		function haeAsiakkaat() {
			$("#listaus tbody").empty();
			$.ajax({url:"asiakkaat/" + $("#hakusana").val(), type:"GET", dataType:"json", success:function(result) {
//				console.log(result); //for testing
				$.each(result.asiakkaat, function(i, field) {
					var htmlStr;
					htmlStr += "<tr>";
//					htmlStr += "<td>" + field.asiakas_id + "</td>"; //commented out for styling
					htmlStr += "<td>" + field.etunimi + "</td>";
					htmlStr += "<td>" + field.sukunimi + "</td>";
					htmlStr += "<td>" + field.puhelin + "</td>";
					htmlStr += "<td>" + field.sposti + "</td>";
					htmlStr += "</tr>";
					$("#listaus tbody").append(htmlStr);
				});
			}});
		}
	</script>
</body>
</html>