scrumAid.controller 'UsersAddToProjectCtrl', [
  '$scope', '$modalInstance', 'Restangular', 'project_id', 'roles'
  ($scope, $modalInstance, Restangular, project_id, roles) ->
    $scope.roles = roles
    
    project = Restangular.one('projects', project_id)

    project.all('users').customGET('to_add').then(
      (response) ->
        $scope.usersToAdd = response
    )
    
    findDefaultRole = () ->
      for role in $scope.roles
        if role.default == true
          $scope.role = role._id.$oid
          
    findDefaultRole()      

    $scope.getUser = (val) ->
      list = []
      for user in $scope.usersToAdd
        if user.username.match(val) or user.email.match(val)
          list.push user
      return list

    $scope.add = () ->
      user_id = $scope.userToAdd._id.$oid
      console.log $scope.role
      project.one('users', user_id).customPOST({role_id: $scope.role}, 'add_to_project').then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )

    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]
