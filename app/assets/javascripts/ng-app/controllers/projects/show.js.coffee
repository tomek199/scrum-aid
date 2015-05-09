scrumAid.controller 'ProjectsShowCtrl', [
  '$scope','$routeParams', 'ProjectsService'
  ($scope, $routeParams, ProjectsService) ->
    $scope.project = {}
    ProjectsService.show(id: $routeParams.id).$promise.then(
      (response) ->
        $scope.project = response
      (error) ->
        console.log error
    )
]
