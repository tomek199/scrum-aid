scrumAid.controller 'RolesUpdateCtrl', [
  '$scope', '$modalInstance', 'ProjectsRolesService', 'project_id', 'role'
  ($scope, $modalInstance, ProjectsRolesService, project_id, role) ->

    $scope.roleName = role.name

    $scope.update = () ->
      role.name = $scope.roleName
      ProjectsRolesService.update({project_id: project_id, role_id: role._id.$oid}, role).$promise.then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]
