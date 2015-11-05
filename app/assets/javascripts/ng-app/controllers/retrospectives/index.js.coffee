scrumAid.controller 'RetrospectivesIndexCtrl', [
  '$scope', '$routeParams', '$location', '$modal', 'Restangular'
  ($scope, $routeParams, $location, $modal, Restangular) ->
    
    project = Restangular.one('projects', $routeParams.project_id)

    project.get().then(
      (response) ->
        $scope.project = response
    )
    
    project.all('sprints').customGET('closed').then(
      (response) ->
        $scope.sprints = response
        if $routeParams.sprint_id
          for sprint in $scope.sprints
            if sprint._id.$oid == $routeParams.sprint_id
              $scope.sprint = sprint
              $scope.get()
    )
    
    $scope.sprint = $routeParams.sprint_id
    
    $scope.get = () ->
      if $scope.sprint
        sprint_id = $scope.sprint._id.$oid
        Restangular.one('sprints', sprint_id).all('retrospectives').getList().then(
          (response) -> 
            $scope.retrospectives = response
        )
      else 
        $scope.retrospectives = []
      
    $scope.new = () ->
      sprint_id = $scope.sprint._id.$oid
      $location.path '/projects/' + $routeParams.project_id + '/sprints/' + sprint_id + '/retrospectives/new'
      
    $scope.show = (index) ->
      modalInstance = $modal.open
        templateUrl: 'retrospectives/show.html'
        controller: 'RetrospectivesShowCtrl'
        size: 'lg'
        resolve:
          retrospective_id: ->
            $scope.retrospectives[index]._id.$oid
      
    $scope.delete = (index) ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-delete.html'
      modalInstance.result.then (result) ->
        retrospective_id = $scope.retrospectives[index]._id.$oid
        Restangular.one('retrospectives', retrospective_id).remove().then(
          (response) ->
            $scope.retrospectives.splice(index, 1)
        )
]
