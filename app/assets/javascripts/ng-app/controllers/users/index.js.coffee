scrumAid.controller 'UsersIndexCtrl', [
  '$scope', '$location', '$routeParams', '$modal', 'CookiesFactory', 'ProjectsService', 'ProjectsUsersService'
  ($scope, $location, $routeParams, $modal, CookiesFactory, ProjectsService, ProjectsUsersService) ->

    ProjectsService.show(id: $routeParams.id).$promise.then(
      (response) ->
        $scope.project = response
        CookiesFactory.putProject({_id: response._id, name: response.name})
      (error) ->
        console.log error
    )

    ProjectsUsersService.index(project_id: $routeParams.id).$promise.then(
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
            $scope.project._id.$oid
      modalInstance.result.then (result) ->
        if result._id?
          $scope.users.push(result)
        else
          console.log(result)

    $scope.delete = (index) ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-delete.html'
      modalInstance.result.then (result) ->
        project_id = $scope.project._id.$oid
        user_id = $scope.users[index]._id.$oid
        ProjectsUsersService.removeFromProject(project_id: project_id, user_id: user_id).$promise.then(
          (response) ->
            $scope.users.splice(index, 1)
          (error) ->
        )

    $scope.isOwnerOrCurrentUser = (index) ->
      if $scope.users[index]._id.$oid == $scope.project.owner_id.$oid
        return true
      if $scope.users[index]._id.$oid == CookiesFactory.getUser()._id.$oid
        return true
      false
]
