scrumAid.controller 'EventsUpdateCtrl', [
  '$scope', '$modalInstance', 'CookiesFactory', 'Restangular', 'event'
  ($scope, $modalInstance, CookiesFactory, Restangular, event) ->
    
    init = () ->    
      $scope.datepickers = [
        {opened: false}
        {opened: false}
      ]   
      $scope.color = event.color
      $scope.title = event.title
      $scope.description = event.description
      $scope.start = new Date(event.start)
      $scope.end = new Date(event.end) if event.end
      $scope.allDay = event.allDay
      
    init()
    
    $scope.updateAllDay = () ->
      $scope.allDay = ($scope.color == 'green')
      $scope.title = CookiesFactory.getUser().username + " - absence" if $scope.color == 'green'
    
    $scope.updateEndDate = () ->
      if $scope.start > $scope.end
        $scope.end = $scope.start
        
    $scope.open = ($event, index) ->
      $scope.datepickers[index].opened = true
    
    $scope.update = () ->
      event.title = $scope.title
      event.description = $scope.description
      event.start = $scope.start
      event.end = $scope.end
      event.allDay = $scope.allDay
      event.color = $scope.color
      Restangular.all('events').customPUT(event, event._id.$oid).then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]
