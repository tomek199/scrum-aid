scrumAid.controller 'RetrospectivesIndexCtrl', [
  '$scope', '$routeParams', 'Restangular'
  ($scope, $routeParams, Restangular) ->
    
    project = Restangular.one('projects', $routeParams.project_id)

    project.get().then(
      (response) ->
        $scope.project = response
    )
]
