var districts;
var clickHandler;
var map;
var lat;
var lng;
var locations;
var bounds;

$(document).ready(function(){

	if (GBrowserIsCompatible()) {
		map = new GMap2(document.getElementById("map"));
		map.addControl(new GLargeMapControl());
		map.addControl(new GMapTypeControl());
		map.setCenter(new GLatLng(37.4419, -122.1419), 13);
		
		// Add 10 markers to the map at random locations
		var bounds = map.getBounds();
		var southWest = bounds.getSouthWest();
		var northEast = bounds.getNorthEast();
		var lngSpan = northEast.lng() - southWest.lng();
		var latSpan = northEast.lat() - southWest.lat();
		for (var i = 0; i < 10; i++) {
			var point = new GLatLng(southWest.lat() + latSpan * Math.random(), southWest.lng() + lngSpan * Math.random());
			map.addOverlay(new GMarker(point));
		}
	}
	
	handleResize();
	
	$('#button-sidebar').click(function(event) {
	
		if ($('#sidebar').is(':visible')) { 
			
			$('#sidebar').animate({width:'hide'});
			$('#map-wrapper').css( {'margin-right': '0px'} );			
/*			$('body').addClass('sidebar-off'); */
/*			$('#sidebar').hide('slow');

*/			
		} else {
			$('#sidebar').animate({width:'show'});
			$('#map-wrapper').css( {'margin-right': '300px'} );					
/*
			$('#sidebar').show('slow');			
			$('#map-wrapper').css( {'margin-right': '300px'} ).show('slow')			
			$('body').removeClass('sidebar-off'); 
*/			
		}
	});
		
	
		
	/*    
	 $('a#new_location').click(function() {
	 $('a#new_location').hide();
	 $('div#info').show('slow');
	 clickHandler = GEvent.addListener(map, "click", function(marker, point) {
	 setNewMarker(point);
	 });
	 });
	 
	 $('a#save').click(function() {
	 $('div#formular').hide('slow');
	 $.post('http://olbertz.de/jquery/locations.php',
	 { type: 'upload',
	 name: $('form').find('input').get(0).value,
	 latitude: lat,
	 longitude: lng
	 },
	 processLocations );
	 });
	 
	 $('a#cancel').click(function() {
	 $('div#formular').hide('slow');
	 });
	 
	 $('a#zoom_show_all').click(function() {
	 zoomShowAll();
	 });
	 */
});
    

function setNewMarker(point) {
    $('div#formular').show('slow');
    $('a#new_location').show();
    $('div#info').hide();
    lat = point.lat();
    lng = point.lng();
    $('div#formular').find('p:nth-of-type(0) ').html('Latitude=<b>'+lat+'</b>, Longitude=<b>'+lng+'</b>');
    $('div#formular').show();
    GEvent.removeListener(clickHandler);
}

function processLocations(content) {
    eval("locations = "+content);
    $('p#location_list').html('');
    locations.forEach(function(element, index, array) {
        var marker = new GMarker(new GLatLng(element.latitude, element.longitude), {title: element.name});
        map.addOverlay(marker);
        GEvent.addListener(marker, 'click', function() {
            marker.openInfoWindowHtml('Name: <b>'+element.name+'</b><br />Latitude: <b>'+element.latitude+'</b><br />Longitude: <b>'+element.longitude+'</b>');       
        });
        link = '<a href="#" onclick="moveMapTo('+index+')">'+element.name+'</a><br />';
        $('p#location_list').append(link);
    });
    zoomShowAll();
}

function moveMapTo(index) {
    map.panTo(new GLatLng(locations[index].latitude, locations[index].longitude));
}

function zoomShowAll() {
    bounds = new GLatLngBounds();
    map.setCenter(new GLatLng(0,0),0);
    
    locations.forEach(function(elemet, id, array) {
        bounds.extend(new GLatLng(locations[id].latitude, locations[id].longitude));
    });
    map.setZoom(map.getBoundsZoomLevel(bounds));
    var clat = (bounds.getNorthEast().lat() + bounds.getSouthWest().lat()) /2;
    var clng = (bounds.getNorthEast().lng() + bounds.getSouthWest().lng()) /2;
    map.setCenter(new GLatLng(clat,clng));
}


function windowHeight() {
	// Standard browsers (Mozilla, Safari, etc.)
	if (self.innerHeight)
		return self.innerHeight;
	// IE 6
	if (document.documentElement && document.documentElement.clientHeight)
		return y = document.documentElement.clientHeight;
	// IE 5
	if (document.body)
		return document.body.clientHeight;
	// Just in case.
		return 0;
}

function handleResize() {
	var height = windowHeight();
	height -= document.getElementById('toolbar').offsetHeight - 30;
	document.getElementById('map').style.height = height + 'px';
	document.getElementById('sidebar').style.height = height + 'px';
}

$(window).bind('resize', handleResize);