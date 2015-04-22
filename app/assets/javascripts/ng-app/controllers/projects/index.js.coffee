scrumAid.controller 'ProjectsIndexCtrl', [
  '$scope', 'ProjectsService'
  ($scope, ProjectsService) ->
    ProjectsService.index().$promise.then(
      (response) ->
        $scope.projects = response
      (error) ->
        console.log error
    )
]
