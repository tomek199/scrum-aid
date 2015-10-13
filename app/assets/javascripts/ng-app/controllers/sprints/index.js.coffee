scrumAid.controller 'SprintsIndexCtrl', [
  '$scope', '$routeParams', '$location', '$modal', 'Restangular'
  ($scope, $routeParams, $location, $modal, Restangular) ->

    project = Restangular.one('projects', $routeParams.project_id)

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
      
    $scope.update = (index) ->
      modalInstance = $modal.open
        templateUrl: 'sprints/update.html'
        controller: 'SprintsUpdateCtrl'
        size: 'lg'
        resolve:
          project: ->
            $scope.project
          sprint: ->
            $scope.sprints[index]
          lastSprint: ->
            $scope.sprints[index - 1]
          nextSprint: ->
            $scope.sprints[index + 1]
      modalInstance.result.then (result) ->
        if result._id?
          $scope.sprints[index] = result
          
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
        project_id = $routeParams.project_id
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
        
    $scope.show = (index) ->
      sprint_id = $scope.sprints[index]._id.$oid
      $location.path '/projects/' + $routeParams.project_id + '/sprints/' + sprint_id
]
