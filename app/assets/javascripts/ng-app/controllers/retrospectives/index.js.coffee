scrumAid.controller 'RetrospectivesIndexCtrl', [
  '$scope', '$routeParams', '$location', 'Restangular'
  ($scope, $routeParams, $location, Restangular) ->
    
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
        project.one('sprints', sprint_id).all('retrospectives').getList().then(
          (response) -> 
            $scope.retrospectives = response
        )
      
    $scope.new = () ->
      sprint_id = $scope.sprint._id.$oid
      $location.path '/projects/' + $routeParams.project_id + '/sprints/' + sprint_id + '/retrospectives/new'
]
