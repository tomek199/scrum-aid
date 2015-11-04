scrumAid.controller 'RolesUpdateCtrl', [
  '$scope', '$modalInstance', 'Restangular', 'role'
  ($scope, $modalInstance, Restangular, role) ->

    $scope.roleName = role.name

    $scope.update = () ->
      role.name = $scope.roleName
      Restangular.all('roles').customPUT(role, role._id.$oid).then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]
