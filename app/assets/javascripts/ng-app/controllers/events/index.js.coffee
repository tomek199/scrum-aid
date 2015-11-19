scrumAid.controller 'EventsIndexCtrl', [
  '$scope', '$routeParams', '$modal', 'Restangular'
  ($scope, $routeParams, $modal, Restangular) ->

    project = Restangular.one('projects', $routeParams.project_id)
            
    $scope.eventSources = []

    project.get().then(
      (response) ->
        $scope.project = response
    )
    
    project.getList('events').then(
      (response) -> 
        $scope.events = response
        $scope.eventSources.push($scope.events)
    )
    
    $scope.uiConfig = {
      calendar:
        editable: true
        header:
          left: 'month agendaWeek agendaDay'
          center: 'title'
          right: 'today prev,next'
    }
    
    $scope.new = () ->
      modalInstance = $modal.open
        templateUrl: 'events/add.html'
        controller: 'EventsCreateCtrl'
        size: 'lg'
        resolve:
          project_id: ->
            $scope.project._id.$oid
      modalInstance.result.then (result) ->
        if result._id?
          $scope.events.push(result)
]
