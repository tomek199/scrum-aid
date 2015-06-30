scrumAid.controller 'UsersAddToProjectCtrl', [
  '$scope', '$modalInstance', 'ProjectsUsersService', 'project_id'
  ($scope, $modalInstance, ProjectsUsersService, project_id) ->
    $scope.usersToAdd = []
    $scope.userToAdd = {}

    ProjectsUsersService.toAdd(project_id: project_id).$promise.then(
      (response) ->
        $scope.usersToAdd = response
    )

    $scope.getUser = (val) ->
#      todo Check DefiantJS
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]
