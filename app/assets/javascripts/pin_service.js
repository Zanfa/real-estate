angular.module('realestate.services')
  .factory('PinService', ['$http', '$q', function ($http, $q) {

    return {
      getPins: function (sw, ne) {
        var deferred = $q.defer();
        var coords = [sw.lat, sw.lng, ne.lat, ne.lng];
        for (var i = 0; i < coords.length; i++) 
          coords[i] = coords[i].toString().replace('.', ',');
        $http.get('/listings/rect/' + coords.join('/'))
          .success(function (data) {
            deferred.resolve(data);
          })
          .error(function () {
            deferred.resolve(null);
          });

        return deferred.promise;
      }
    } 
    
  }]);

