scrumAid.controller 'SprintsIndexCtrl', [
  '$scope', '$routeParams', '$modal', 'Restangular'
  ($scope, $routeParams, $modal, Restangular) ->
    Restangular.one('projects', $routeParams.id).get().then(
      (response) ->
        $scope.project = response
    )

    $scope.new = () ->
      modalInstance = $modal.open
        templateUrl: 'sprints/add.html'
        controller: 'SprintsCreateCtrl'
        size: 'lg'
      modalInstance.result.then (result) ->
        if result._id?
#          todo
        else
          console.log(result)
]
