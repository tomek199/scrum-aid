scrumAid.controller 'UsersIndexCtrl', [
  '$scope', '$location', '$modal', 'CookiesFactory', 'ProjectsUsersService'
  ($scope, $location, $modal, CookiesFactory, ProjectsUsersService) ->
    $scope.project = CookiesFactory.getProject
    $scope.users = []

    ProjectsUsersService.index(project_id: $scope.project()._id.$oid).$promise.then(
      (response) ->
        $scope.users = response
      (error) ->
        console.log error
    )

    $scope.addUsers = () ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-addUserToProject.html'
        controller: 'UsersAddToProjectCtrl'
        size: 'md'
        resolve:
          project_id: ->
            $scope.project()._id.$oid
      modalInstance.result.then (result) ->
]
