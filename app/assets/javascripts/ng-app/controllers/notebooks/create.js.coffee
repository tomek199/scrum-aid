scrumAid.controller 'NotebooksCreateCtrl', [
  '$scope', '$modalInstance', 'Restangular', 'project_id'
  ($scope, $modalInstance, Restangular, project_id) ->
    
    $scope.create = () ->
      Restangular.one('projects', project_id).one('notebooks').post('', {notebook: $scope.notebook}).then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
      
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]
