scrumAid.controller 'RetrospectivesCreateCtrl', [
  '$scope', '$routeParams', 'Restangular'
  ($scope, $routeParams, Restangular) ->
    
    project = Restangular.one('projects', $routeParams.project_id)

    project.get().then(
      (response) ->
        $scope.project = response
    )
    
    project.one('sprints', $routeParams.sprint_id).get().then(
      (response) ->
        $scope.sprint = response
    )
]
