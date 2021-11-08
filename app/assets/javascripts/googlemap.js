let map
let geocoder

function initMap(){
  geocoder = new google.maps.Geocoder()
  geocoder.geocode( { 'address': $('#map').attr('class')}, function(results, status) {
    if (status == 'OK') {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });

  map = new google.maps.Map(document.getElementById('map'), {
  center: {lat: -35.6809591, lng: 139.7673068},
  zoom: 13
  });
}

function codeAddress(){
  let inputAddress = document.getElementById('address').value;
}