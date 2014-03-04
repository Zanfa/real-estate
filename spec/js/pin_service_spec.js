describe('PinService', function () {
  var $httpBackend, PinService;

  beforeEach(module('realestate.services'));

  beforeEach(function () {

    inject(function ($injector) {
      $httpBackend = $injector.get('$httpBackend');
      PinService = $injector.get('PinService');
    });
    
  });

  afterEach(function () {
    $httpBackend.verifyNoOutstandingExpectation();
    $httpBackend.verifyNoOutstandingRequest();
  });

  it('should ask the server for pins in certain bounds', function () {
    var pinsLength = 0;
    $httpBackend.expectGET('/listings/rect/0,123/0,123/1,123/1,123').respond(200, JSON.stringify(
      [
        {lat: 0, lng: 0},
        {lat: 1, lng: 1},
        {lat: 2, lng: 2}
      ]
    ));
    PinService.getPins({lat: 0.123, lng: 0.123}, {lat: 1.123, lng: 1.123}).then(function (pins) {
      pinsLength = pins.length;
    });

    $httpBackend.flush();

    expect(pinsLength).toEqual(3);
  });
});

