scrumAid.controller 'RolesCreateCtrl', [
  '$scope', '$modalInstance', 'Restangular', 'project_id'
  ($scope, $modalInstance, Restangular, project_id) ->

    $scope.create = () ->
      Restangular.one('projects', project_id).one('roles').post('', $scope.role).then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]
