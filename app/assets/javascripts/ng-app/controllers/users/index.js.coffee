scrumAid.controller 'UsersIndexCtrl', [
  '$scope', '$location', 'CookiesFactory', 'ProjectsUsersService'
  ($scope, $location, CookiesFactory, ProjectsUsersService) ->
    $scope.project = CookiesFactory.getProject
    $scope.users = []

    ProjectsUsersService.index(project_id: $scope.project()._id.$oid).$promise.then(
      (response) ->
        $scope.users = response
      (error) ->
        console.log error
    )
]
