
var map;
var centerLatitude = '48.137118';
var centerLongitude = '11.574448'; 
var startZoom = 3;
var gmarkers = [];


$(document).ready( function() {

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
	
	   $('#nav_'+this.id.substring(5)).trigger('click');
	   showMarkers(e, this.id.substring(5) );
	   
	})
	

    // This is to trigger the click on 2008
    el = $('ul.navigation li:last a')
    el.addClass('selected')
    $(el).trigger('click');
    $('#'+last_year_month).trigger('click');

});


function myclick(i) {
        GEvent.trigger(gmarkers[i], "click");
}


   function showMarkers(event, el) {
  	
	    var key = el;
        var location;
		var store_list;

	    // Add stores markers	
		if (key.indexOf('-') == -1) {
		  store_list = stores_by_year[key];
		  $('#sidebar h5').html('Opened in: '+ key + ' ('+ store_list.length +')') 
		} else {
		  year = key.substring(0,4);
		  month = key.substring(5); 
		  store_list = stores_by_year_month[key];
  		  $('#sidebar h5').html('Opened in: '+ abbr_monthnames[month] + ', ' + year + ' ('+ store_list.length +')');	
		}

		// 1. rebuild siderbar
		gmarkers = [];
		
		$('#sidebar h4').html() 
		
		ul = $('ul#stores').html('');
		for( var i = 0, n = store_list.length;  i < n;  ++i ) { 
	        key = store_list[i]; 
	        // your code here 
  		    store = stores[key]['store'];
			ul.append( '<li id="'+store['code']+'"><a href="javascript:myclick(' + i + ')">' + 
			            store['title'] + ', ' + store['country'] + '</a></li>' );
	    }
	
		// <li id="store_47973125"><a href="#">Chadstone (R180)</a></li>
		// 2. 		


		map.clearOverlays();

		// Loop each store and add a marker
		for( var i = 0, n = store_list.length;  i < n;  ++i ) { 
			key = store_list[i]; 
			store = stores[key]['store'];
			addMarker(store['lat'], store['lng'], store['title'], store);
			if (i == 0) {
			   map.setCenter(new GLatLng(store['lat'], store['lng']), map.getZoom() );
		    }
		}	

	}
	
function addMarker(lat, lng, description, store){
  var marker = new GMarker( new GLatLng( lat,lng),
        {title: description});

  var html = '<div class="store"><p>Store Name: <a target="_BLANK" href="'+ store['url'] + '">' + store['title'] + '</a></p> ' +
             '<p>Adresss: ' + store['street_address'] + '</p>' +
             '<p>Locality: ' + store['locality'] + ' Region: ' + store['region'] + '</p>' +
             '<p>Country: ' + store['country'] + '</p>' +
             '<p>Date Opened: ' + store['date_open'] + '</p>' +
             '<img src="' + store['image_url'] + '" width="210" height="160" alt="store image"/></div>'; 
  GEvent.addListener(marker,'click', 
     function() {
	 	marker.openInfoWindowHtml( html );
	 } 
  );		  
  gmarkers.push(marker);
  
  map.addOverlay( marker );

	
}




