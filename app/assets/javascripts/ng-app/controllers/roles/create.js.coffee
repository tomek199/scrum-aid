scrumAid.controller 'RolesCreateCtrl', [
  '$scope', '$modalInstance', 'ProjectsRolesService', 'project_id'
  ($scope, $modalInstance, ProjectsRolesService, project_id) ->

    $scope.create = () ->
      ProjectsRolesService.create(project_id: project_id, $scope.role).$promise.then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]
