<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.io.*, java.net.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>

</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="#">Vaccination</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="index.jsp">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="first.jsp">1st
						dose per day</a></li>
				<li class="nav-item"><a class="nav-link" href="second.jsp">2nd
						dose per day</a></li>
				<li class="nav-item"><a class="nav-link" href="third.jsp">Distinct People</a></li>
			</ul>
		</div>
	</nav>
	<div class="container">
	<div class="row">
	
	<h2>Complete Vaccination daily data</h2>
	
	<table class="table table-striped" id="data">
		<thead>
			<tr>
				<th>Date</th>
				<th>Total Dose 1</th>
				<th>Total Dose 2</th>
				<th>Total Distinct Persons</th>
				<th>Total Vaccinations</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	</div> </div>
	<script>
		function findIndex(data, referencedate) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].referencedate == referencedate) {
					return i;
				}
			}

			return -1;
		}

		$.ajax({
			url : 'FetchData',
			success : function(data) {
				let html = '';

				var result = [];
				$
						.each(
								data,
								function(key, value) {
									let idx = findIndex(result,
											value['referencedate']);

									if (idx == -1) {
										result
												.push({
													referencedate : value['referencedate'],
													totaldose1 : value['totaldose1'],
													totaldose2 : value['totaldose2'],
													totaldistinctpersons : value['totaldistinctpersons'],
													totalvaccinations : value['totalvaccinations']
												})
									} else {
										result[idx].totaldose1 += value['totaldose1'];
									}
								});

				$.each(result, function(key, value) {

					let d = new Date(value.referencedate);
					html += '<tr><td>' + d.toLocaleDateString()
							+ '</td><td>' + value.totaldose1
							+ '</td><td>' + value.totaldose2
							+ '</td><td>' + value.totaldistinctpersons
							+ '</td><td>' + value.totalvaccinations
							+ '</td></tr>';
				});
				$('#data').append(html);
			}
		});
	</script>
</body>
</html>