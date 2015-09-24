scrumAid.controller 'SprintsCreateCtrl', [
  '$scope', '$modalInstance', 'Restangular', 'project'
  ($scope, $modalInstance, Restangular, project) ->
    $scope.datepickers = [
      {opened: false}
      {opened: false}
    ]

    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')

    $scope.open = ($event, index) ->
      $scope.datepickers[index].opened = true

    $scope.create = () ->
      Restangular.one('projects', project._id.$oid).one('sprints').post('', {sprint: $scope.sprint}).then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
]
