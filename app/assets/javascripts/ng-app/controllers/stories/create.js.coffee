scrumAid.controller 'StoriesCreateCtrl', [
  '$scope', '$modalInstance', 'Restangular', 'project_id'
  ($scope, $modalInstance, Restangular, project_id) ->
    
    $scope.points = [0, 1.5, 1, 2, 3, 5, 8, 13, 20, 40, 100]
    $scope.story = {
      points: 0
    }
    
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')

    $scope.create = () ->
      Restangular.one('projects', project_id).one('stories').post('', {story: $scope.story}).then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
]
