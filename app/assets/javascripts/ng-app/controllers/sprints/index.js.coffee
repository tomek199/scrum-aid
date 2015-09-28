scrumAid.controller 'SprintsIndexCtrl', [
  '$scope', '$routeParams', '$modal', 'Restangular'
  ($scope, $routeParams, $modal, Restangular) ->

    project = Restangular.one('projects', $routeParams.id)

    project.get().then(
      (response) ->
        $scope.project = response
    )

    project.getList('sprints').then(
      (response) ->
        $scope.sprints = response
    )

    $scope.new = () ->
      modalInstance = $modal.open
        templateUrl: 'sprints/add.html'
        controller: 'SprintsCreateCtrl'
        size: 'lg'
        resolve:
          project: ->
            $scope.project
          lastSprint: ->
            if $scope.sprints.length > 0
              $scope.sprints[$scope.sprints.length - 1]
            else
              undefined
      modalInstance.result.then (result) ->
        if result._id?
          $scope.sprints.push(result)
        else
          console.log(result)
      
    $scope.edit = (index) ->
      console.log $scope.sprints[index]
      # TODO
          
    $scope.close = (index) ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-closeSprint.html'
      modalInstance.result.then (result) ->
        sprint_id = $scope.sprints[index]._id.$oid
        project.all('sprints').customPUT({closed: true, current: false}, sprint_id).then(
          (response) -> 
            $scope.sprints[index] = response
        )
        
    $scope.delete = (index) ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-delete.html'
      modalInstance.result.then (result) ->
        project_id = $routeParams.id
        sprint_id = $scope.sprints[index]._id.$oid
        project.one('sprints', sprint_id).remove().then(
          (response) ->
            $scope.sprints.splice(index, 1)
        )
        
    $scope.start = (index) ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-startSprint.html'
      modalInstance.result.then (result) ->
        sprint_id = $scope.sprints[index]._id.$oid
        project.one('sprints', sprint_id).customPOST('', 'start').then(
          (response) ->
            $scope.sprints = response
        )
]
