scrumAid.controller 'ProjectsCreateCtrl', [
  '$scope', '$modalInstance', 'Restangular'
  ($scope, $modalInstance, Restangular) ->
    $scope.project = {}

    $scope.create = () ->
      Restangular.one('projects').post('', $scope.project).then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]