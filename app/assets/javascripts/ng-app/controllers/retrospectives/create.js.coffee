scrumAid.controller 'RetrospectivesCreateCtrl', [
  '$scope', '$routeParams', '$location', 'Restangular'
  ($scope, $routeParams, $location, Restangular) ->
    
    project = Restangular.one('projects', $routeParams.project_id)
    
    init = () ->
      $scope.datepicker = {opened: false}

      project.get().then(
        (response) ->
          $scope.project = response
      )
    
      project.one('sprints', $routeParams.sprint_id).get().then(
        (response) ->
          $scope.sprint = response
          $scope.retrospective = {
            date: new Date($scope.sprint.end_date)
            name: $scope.sprint.name + ' retrospective'
          }
      )
    
    init()
      
    $scope.open = ($vent) ->
      $scope.datepicker.opened = true
      
    $scope.back = () ->
      $location.path '/projects/' + $routeParams.project_id + '/sprints/' + $routeParams.sprint_id + '/retrospectives'
]
