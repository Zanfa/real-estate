describe('MapController', function () {
  var $scope, $q, deferred, PinServiceMock, leafletDataMock, mapMock;

  beforeEach(module('realestate.controllers'));

  beforeEach(function () {
    PinServiceMock = {
      getPins: function (sw, ne) {
        return deferred.promise;
      }
    };

    mapMock = {
      // Return some dummy coordinates
      getBounds: function () {
        return { 
          getSouthWest: function () {
            return {lat: 0, lng: 0};
          },
          getNorthEast: function () {
            return {lat: 1, lng: 1};
          }
        }
      }
    };
    
    leafletDataMock = {
      getMap: function() {
        return deferred.promise;
      }
    };

    module(function($provide) {
      $provide.value('leafletData', leafletDataMock);
      $provide.value('PinService', PinServiceMock);
    });

  });

  beforeEach(inject(function(_$q_, $rootScope, $controller) {
    $q = _$q_;
    $scope = $rootScope.$new();

    deferred = $q.defer();
    $controller('MapController', {$scope: $scope});
    deferred.resolve(mapMock);
  }));

  it('should get bounds', function () {
    spyOn(mapMock, 'getBounds').andCallThrough();
    $scope.$apply();
    expect(mapMock.getBounds).toHaveBeenCalled();
  });

  it('should ask PinService for pins', function () {
    spyOn(PinServiceMock, 'getPins').andCallThrough();
    $scope.$apply();
    expect(PinServiceMock.getPins).toHaveBeenCalledWith({lat: 0, lng: 0}, {lat: 1, lng: 1});
  });

  describe('events', function () {

    beforeEach(function () {
      // Clear the initial getMap promise
      $scope.$apply();

      spyOn(PinServiceMock, 'getPins').andCallThrough();
    });
  
    it('should react to dragend', function () {
      $scope.$emit('leafletDirectiveMap.dragend');
      $scope.$apply();
      expect(PinServiceMock.getPins).toHaveBeenCalledWith({lat: 0, lng: 0}, {lat: 1, lng: 1});
    });

    it('should react to zoom', function () {
      $scope.$emit('leafletDirectiveMap.zoomend');
      $scope.$apply();
      expect(PinServiceMock.getPins).toHaveBeenCalledWith({lat: 0, lng: 0}, {lat: 1, lng: 1});
    });

  });
});

