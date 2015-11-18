scrumAid.controller 'EventsIndexCtrl', [
  '$scope', '$routeParams', '$modal', 'Restangular'
  ($scope, $routeParams, $modal, Restangular) ->

    project = Restangular.one('projects', $routeParams.project_id)

    project.get().then(
      (response) ->
        $scope.project = response
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
