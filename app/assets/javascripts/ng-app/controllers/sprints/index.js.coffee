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
      modalInstance.result.then (result) ->
        if result._id?
          $scope.sprints.push(result)
        else
          console.log(result)
]
