scrumAid.controller 'EventsIndexCtrl', [
  '$scope', '$routeParams', '$modal', 'Restangular'
  ($scope, $routeParams, $modal, Restangular) ->

    project = Restangular.one('projects', $routeParams.project_id)
    
    $scope.events = []

    project.get().then(
      (response) ->
        $scope.project = response
    )
    
    project.getList('events').then(
      (response) -> 
        $scope.events.push(response)
    )
    
    $scope.uiConfig = {
      calendar:
        editable: true
        header:
          left: 'month agendaWeek agendaDay'
          center: 'title'
          right: 'today prev,next'
    }
]
