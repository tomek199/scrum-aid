scrumAid.controller 'NotesIndexCtrl', [
  '$scope', '$routeParams', '$modal', 'Restangular'
  ($scope, $routeParams, $modal, Restangular) ->
    
    project = Restangular.one('projects', $routeParams.project_id)

    project.get().then(
      (response) ->
        $scope.project = response
    )
    
    Restangular.one('notebooks', $routeParams.notebook_id).get().then(
      (response) ->
        $scope.notebook = response
    )
]
