$( document ).ready(function() {

	$.get( "/currencies/chart", function( data ) {
	  var chart = c3.generate({
	    data: {
	        columns: data['currencies'],
	        type : 'donut',
	       
	    },
	    donut: {
	        title: "Your currencies"
	    }
	});

	setInterval(function () {
    $.get( "/currencies/chart", function( data ) {
	   chart.load({
        columns: data['currencies']
    });
	});
   
}, 2000);

	});
});