scrumAid.controller 'RolesUpdateCtrl', [
  '$scope', '$modalInstance', 'Restangular', 'project_id', 'role'
  ($scope, $modalInstance, Restangular, project_id, role) ->

    $scope.roleName = role.name

    $scope.update = () ->
      role.name = $scope.roleName
      Restangular.one('projects', project_id).all('roles').customPUT(role, role._id.$oid).then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]
