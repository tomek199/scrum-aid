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
      note_id = $scope.notes[index]._id
      
      if !note_id
        notebook.one('notes').post('', note: note).then(
          (response) ->
            $scope.notes[index] = response
        )
      else
        notebook.one('notes').customPUT(note, note_id.$oid).then(
          (response) ->
            $scope.notes[index] = response
        )
      
    $scope.cancel = (index) ->
      $scope.temp = null
      if !$scope.notes[index]._id
        $scope.notes.splice(index, 1)
        
    $scope.moveToTrash = (index) ->      
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-delete.html'
      modalInstance.result.then (result) ->
        note_id = $scope.notes[index]._id.$oid
        notebook.one('notes', note_id).customPOST('', 'move_to_trash').then(
          (response) ->
            $scope.notes.splice(index, 1)
        )
        
    $scope.delete = (index) ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-delete.html'
      modalInstance.result.then (result) ->
        note_id = $scope.notes[index]._id.$oid
        notebook.one('notes', note_id).remove().then(
          (response) ->
            $scope.notes.splice(index, 1)
        )
]
