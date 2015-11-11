scrumAid.controller 'NotebooksUpdateCtrl', [
  '$scope', '$modalInstance', 'Restangular', 'notebook'
  ($scope, $modalInstance, Restangular, notebook) ->

    $scope.name = notebook.name
    $scope.description = notebook.description

    $scope.update = () ->
      notebook.name = $scope.name
      notebook.description = $scope.description
      Restangular.all('notebooks').customPUT(notebook, notebook._id.$oid).then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]
