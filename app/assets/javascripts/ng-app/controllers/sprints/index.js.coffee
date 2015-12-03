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
    
    project.getList('stories').then(
      (response) ->
        $scope.stories = response
    )

    $scope.newSprint = () ->
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
      
    $scope.updateSprint = (index) ->
      modalInstance = $modal.open
        templateUrl: 'sprints/update.html'
        controller: 'SprintsUpdateCtrl'
        size: 'lg'
        resolve:
          sprint: ->
            $scope.sprints[index]
          lastSprint: ->
            $scope.sprints[index - 1]
          nextSprint: ->
            $scope.sprints[index + 1]
      modalInstance.result.then (result) ->
        if result._id?
          $scope.sprints[index] = result
          
    $scope.closeSprint = (index) ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-closeSprint.html'
      modalInstance.result.then (result) ->
        sprint_id = $scope.sprints[index]._id.$oid
        Restangular.all('sprints').customPUT({closed: true, current: false}, sprint_id).then(
          (response) -> 
            $scope.sprints[index] = response
        )
        
    $scope.deleteSprint = (index) ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-delete.html'
      modalInstance.result.then (result) ->
        sprint_id = $scope.sprints[index]._id.$oid
        Restangular.one('sprints', sprint_id).remove().then(
          (response) ->
            $scope.sprints.splice(index, 1)
        )
        
    $scope.startSprint = (index) ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-startSprint.html'
      modalInstance.result.then (result) ->
        sprint_id = $scope.sprints[index]._id.$oid
        project.one('sprints', sprint_id).customPOST('', 'start').then(
          (response) ->
            $scope.sprints = response
        )
        
    $scope.showSprint = (index) ->
      sprint_id = $scope.sprints[index]._id.$oid
      $location.path '/projects/' + $routeParams.project_id + '/sprints/' + sprint_id
      
    $scope.newStory = () ->
      modalInstance = $modal.open
        templateUrl: 'stories/add.html'
        controller: 'StoriesCreateCtrl'
        size: 'lg'
        resolve:
          project_id: ->
            $scope.project._id.$oid
      modalInstance.result.then (result) ->
        if result._id?
          $scope.stories.push(result)
    
    $scope.showStory = (index) -> 
      $scope.selectedStory = $scope.stories[index]
    
    $scope.closeStoryDetails = () ->
      $scope.selectedStory = null
]
