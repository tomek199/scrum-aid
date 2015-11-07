scrumAid.controller 'NotebooksIndexCtrl', [
  '$scope', '$routeParams', '$location', '$modal', 'Restangular'
  ($scope, $routeParams, $location, $modal, Restangular) ->

    project = Restangular.one('projects', $routeParams.project_id)

    project.get().then(
      (response) ->
        $scope.project = response
    )

    # project.getList('notebooks').then(
#       (response) ->
#         $scope.notebooks = response
#     )

]
