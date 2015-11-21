scrumAid.controller 'EventsCreateCtrl', [
  '$scope', '$modalInstance', 'CookiesFactory', 'Restangular', 'project_id'
  ($scope, $modalInstance, CookiesFactory, Restangular, project_id) ->
    
    init = () ->    
      $scope.datepickers = [
        {opened: false}
        {opened: false}
      ]   
      
      $scope.event = {
        color: 'blue'
        start: new Date()
        end: new Date()
        allDay: false
      }
      
    init()
    
    $scope.$watch 'event.color', (value) ->
      $scope.event.allDay = (value == 'green')
      $scope.event.title = CookiesFactory.getUser().username + " - absence" if value == 'green'      
    
    $scope.updateEndDate = () ->
      if $scope.event.start > $scope.event.end
        $scope.event.end = $scope.event.start

    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')

    $scope.open = ($event, index) ->
      $scope.datepickers[index].opened = true

    $scope.create = () ->
      if $scope.event.allDay
        $scope.event.end = $scope.event.start
      Restangular.one('projects', project_id).one('events').post('', {event: $scope.event}).then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
]
