scrumAid.controller 'NotesIndexCtrl', [
  '$scope', '$routeParams', '$modal', 'Restangular'
  ($scope, $routeParams, $modal, Restangular) ->
    
    project = Restangular.one('projects', $routeParams.project_id)

    project.get().then(
      (response) ->
        $scope.project = response
    )
    
    notebook = Restangular.one('notebooks', $routeParams.notebook_id)
    
    notebook.get().then(
      (response) ->
        $scope.notebook = response
    )
    
    notebook.all('notes').getList().then(
      (response) ->
        $scope.notes = response
    )
]
