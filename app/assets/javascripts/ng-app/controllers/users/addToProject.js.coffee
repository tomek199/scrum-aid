scrumAid.controller 'UsersAddToProjectCtrl', [
  '$scope', '$modalInstance', 'ProjectsUsersService', 'project_id', 'roles'
  ($scope, $modalInstance, ProjectsUsersService, project_id, roles) ->
    $scope.roles = roles

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
      console.log $scope.role
      ProjectsUsersService.addToProject({project_id: project_id, user_id: user_id}, {role_id: $scope.role}).$promise.then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )

    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]
