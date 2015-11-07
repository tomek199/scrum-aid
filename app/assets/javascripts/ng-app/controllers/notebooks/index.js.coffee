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
]
