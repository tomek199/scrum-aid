scrumAid.controller 'SprintsIndexCtrl', [
  '$scope', '$routeParams', '$modal', 'ProjectsService'
  ($scope, $routeParams, $modal, ProjectsService) ->
    ProjectsService.show(id: $routeParams.id).$promise.then(
      (response) ->
        $scope.project = response
      (error) ->
        console.log error
    )
]
