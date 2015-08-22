scrumAid.controller 'UsersAddToProjectCtrl', [
  '$scope', '$modalInstance', 'ProjectsUsersService', 'project_id'
  ($scope, $modalInstance, ProjectsUsersService, project_id) ->
    $scope.usersToAdd = []
    $scope.userToAdd = undefined

    ProjectsUsersService.toAdd(project_id: project_id).$promise.then(
      (response) ->
        $scope.usersToAdd = response
    )

    $scope.getUser = (val) ->
      list = []
      for user in $scope.usersToAdd
        if user.username.match(val) or user.email.match(val)
          list.push user
      return list

    $scope.add = () ->
      user_id = $scope.userToAdd._id.$oid
      ProjectsUsersService.addToProject({project_id: project_id, user_id: user_id}, {}).$promise.then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )

    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]
