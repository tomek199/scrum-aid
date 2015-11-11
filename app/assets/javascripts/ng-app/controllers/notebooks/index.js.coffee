scrumAid.controller 'NotebooksIndexCtrl', [
  '$scope', '$routeParams', '$location', '$modal', 'Restangular'
  ($scope, $routeParams, $location, $modal, Restangular) ->

    project = Restangular.one('projects', $routeParams.project_id)

    project.get().then(
      (response) ->
        $scope.project = response
    )

    project.getList('notebooks').then(
      (response) ->
        $scope.notebooks = response
    )
    
    $scope.new = () ->
      modalInstance = $modal.open
        templateUrl: 'notebooks/add.html'
        controller: 'NotebooksCreateCtrl'
        size: 'lg'
        resolve:
          project_id: ->
            $scope.project._id.$oid
      modalInstance.result.then (result) ->
        if result._id?
          $scope.notebooks.push(result)
    
    $scope.update = (index) ->
      notebook = $scope.notebooks[index]
      modalInstance = $modal.open
        templateUrl: 'notebooks/update.html'
        controller: 'NotebooksUpdateCtrl'
        size: 'md'
        resolve:
          notebook: notebook

      modalInstance.result.then (result) ->
        if result._id?
          $scope.notebooks[index] = result
          
    $scope.delete = (index) ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-delete.html'
      modalInstance.result.then (result) ->
        notebook_id = $scope.notebooks[index]._id.$oid
        Restangular.one('notebooks', notebook_id).remove().then(
          (response) ->
            $scope.notebooks.splice(index, 1)
          (error) ->
        )
    
    $scope.markAsDefault = (index) ->
      notebook = $scope.notebooks[index]
      project_id = $routeParams.project_id
      project.one('notebooks', notebook._id.$oid).customPOST('', 'mark_as_default').then(
        (response) -> 
          $scope.notebooks = response
      )
]
