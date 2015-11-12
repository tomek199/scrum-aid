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
    
    $scope.checkText = (data) ->
      if !data
        return "Can't be blank"
    
    $scope.add = () ->
      $scope.temp = {text: ""}
      $scope.notes.push($scope.temp)
      
    $scope.save = (data, index) -> 
      $scope.temp = null
      note = {text: data.text}
      notebook.one('notes').post('', note: note).then(
        (response) ->
          $scope.notes[index] = response
      )
      
    $scope.cancel = (index) ->
      $scope.temp = null
      $scope.notes.splice(index, 1)
]
