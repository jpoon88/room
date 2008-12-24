
var map;
var centerLatitude = 49.282484;
var centerLongitude = -123.118145;
var startZoom = 2;
var markers = [];


$(document).ready( function() {

    handleResize();

	if (GBrowserIsCompatible()) {
		map = new GMap2(document.getElementById("map"));
		map.addControl(new GLargeMapControl());
		map.addControl(new GMapTypeControl());
		
		var location = new GLatLng(centerLatitude, centerLongitude);
	    map.setCenter(location, startZoom);

    }

	$("a[@class='month']").click( function(e) { 
	   showMarkers(e, this.id); })
	$("a[@class='year']").click( function(e) { 
	   showMarkers(e, this.id.substring(5) ); })


    /* scroll slider */
	
	var $panels = $("#slider .panel");
	var $container = $('#slider .scrollContainer');
	var $scroll = $('#slider .scroll').css({'overflow':'hidden'});

    // if false, we'll float all the panels left and fix the width 
    // of the container
    var horizontal = true;


   // float the panels left if we're going horizontal
    if (horizontal) {
        $panels.css({
//            'float' : 'left',
//            'position' : 'relative' // IE fix to ensure overflow is hidden
        });

        // calculate a new width for the container (so it holds all panels)
        $container.css('width', ($panels[0].offsetWidth * $panels.length) );
    }
	

    $scroll
      .before('<img src="http://jqueryfordesigners.com/demo/images/scroll_left.png" class="scrollButtons left" />' )
      .after('<img src="http://jqueryfordesigners.com/demo/images/scroll_right.png" class="scrollButtons right" />' );
	
	$('#slider .navigation a').click(selectNav);
	
	function selectNav() {
	  $(this).parents('ul:first').find('a').removeClass('selected').end().end().addClass('selected');
	}
	
	var scrollOptions = {
		target: $scroll,
		items: $panels,
		navigation: '.navigation a',
		prev: 'img.left',
		next: 'img.right',
		axis: 'xy',
		duration: 500,
		easing: 'swing',
		onAfter: trigger
	};

    // go find the navigation link that has this target and select the nav
	function trigger() {
	  //
	}

    // apply serialScroll to the slider - we chose this plugin because it 
    // supports// the indexed next and previous scroll along with hooking 
    // in to our navigation.
    $('#slider').serialScroll(scrollOptions);

    // now apply localScroll to hook any other arbitrary links to trigger 
    // the effect
    $.localScroll(scrollOptions);

   // finally, if the URL has a hash, move the slider in to position, 
    // setting the duration to 1 because I don't want it to scroll in the
    // very first page load.  We don't always need this, but it ensures
    // the positioning is absolutely spot on when the pages loads.
    scrollOptions.duration = 1;
    $.localScroll.hash(scrollOptions);


    // This is to trigger the click on 2008
    el = $('ul.navigation li:last a')
    el.addClass('selected')
    v = '#year_' + el.html()
    $(v).trigger('click'); 

});



   function showMarkers(event, el) {
  	
	    var key = el;
		map.clearOverlays();

	    // Add stores markers	
		if (key.indexOf('-') == -1) {

	  	  for (s in stores_by_year[key]) {
		  	store = stores[stores_by_year[key][s]]['store']
//		  	console.log(store['title']);
		  	addMarker(store['lat'], store['lng'], store['title'], store['url']);
		  }	
		} else {
		  for (s in stores_by_year_month[key]) {
		  	store = stores[stores_by_year_month[key][s]]['store']
//		  	console.log(store['title']);
		  	addMarker(store['lat'], store['lng'], store['title'], store['url']);
		  }
		}
		
	/*
        var pt_ne = new GLatLng( borders[yr]['ne'][0], borders[yr]['ne'][1]);
        var pt_sw = new GLatLng( borders[yr]['sw'][0], borders[yr]['sw'][1]);
		var bounds = new GLatLngBounds( pt_sw, pt_ne );
		map.clearOverlays();
	    map.setCenter( bounds.getCenter(), 2);
		//map.addOverlay(new GMarker(pt_ne));
		//map.addOverlay(new GMarker(pt_sw));

	    // Add stores markers
		for (s in stores_by_year[yr]) {
	      store = stores[ stores_by_year[yr][s] ]['store']
		  console.log( store['lat']    );	
		  var point = new GLatLng( store['lat'],store['lng']);
		  map.addOverlay(new GMarker(point));
		}
*/		
	}

function addMarker(lat, lng, description, url){
  var marker = new GMarker( new GLatLng( lat,lng),
        {title: description});
//console.log(url);
  GEvent.addListener(marker,'click', 
     function() {

		tb_show(description, url+"?KeepThis=true&TB_iframe=true&height=460&width=680", false)	 	
		
	 	//marker.openInfoWindowHtml( description )
	 } 
  );		  


  
  map.addOverlay( marker );
	
}


 // ====== This function displays the tooltip ======
      // it can be called from an icon mousover or a side_bar mouseover


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
	height -= (document.getElementById('header').offsetHeight + 
            	document.getElementById('footer').offsetHeight);
	document.getElementById('map').style.height = height + 'px';
	
	$('#debug').html(height);

}

$(window).bind('resize', handleResize);


