scrumAid.controller 'ProjectsCreateCtrl', [
  '$scope', '$modalInstance', 'ProjectsService'
  ($scope, $modalInstance, ProjectsService) ->
    $scope.project = {}

    $scope.create = () ->
      ProjectsService.create($scope.project).$promise.then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]