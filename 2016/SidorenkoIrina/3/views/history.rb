<h1 class="lead text-center">GAME WORLD OF PHRASES</h1>
<p class="tagline text-center">History of phrase</p>
<div class="prokrutka">
<div> <% @result.each do |row| %>
	   <p><%= row['word']%></p>
	 <%end%>
</div>
<table class="table">
	<thead>
		<tr>
			<th>Name</th>
			<th>Date</th>
			<th>Word</th>
		</tr>
	</thead>
	<body>
	<% @result.each do |row| %>
		<tr>
			<td><%= row['id_user']%></td>
			<td><%= row['time']%> </td>
			<td><%= row['word']%> </td>
		</tr>
	<%end%>
    </body>
</table>

</div><br>
