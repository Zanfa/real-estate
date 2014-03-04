angular.module('realestate.controllers')
  .controller('MapController', ['$scope', 'leafletData', 'PinService', function ($scope, leafletData, PinService) {

    var updatePins = function (pins) {
      var markers = [];

      for (var i = 0, pinsLength = pins.length; i < pinsLength; i++) {
        var coords = pins[i].coords;
        markers.push(coords);
      }

      angular.extend($scope, {
        markers: markers
      });
    };

    var reloadPins = function () {
      leafletData.getMap().then(function (map) {
        $scope.bounds = map.getBounds();
        PinService.getPins($scope.bounds.getSouthWest(), $scope.bounds.getNorthEast()).then(updatePins);
      });
    };

    $scope.$on('leafletDirectiveMap.dragend', reloadPins);
    $scope.$on('leafletDirectiveMap.zoomend', reloadPins);
    reloadPins();

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

  }]);
