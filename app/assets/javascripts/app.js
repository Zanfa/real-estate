angular.module('RealEstateApp', ['leaflet-directive'])
.controller('TestController', function ($scope, leafletData) {
  $scope.hello = 'World';

  // leafletData.getMap().then(function (map) {
  //   $scope.bounds = map.getBounds();
  //   debugger;
  // });

  angular.extend($scope, {
    defaults: {
      tileLayer: "http://{s}.tiles.mapbox.com/v3/zanfa.he4hofpi/{z}/{x}/{y}.png",
      maxZoom: 19
    },
    center: {
      lng: 24.74945068359375,
      lat: 59.43283376037999,
      zoom: 14
    },
    markers: {}
  });

  $scope.addMarker = function () {
    angular.extend($scope, {
      markers: {
        m1: {
          lng: 24.74945068359375,
          lat: 59.43283376037999,
          message: "Marker M"
        }
      }
    });

  };

});
