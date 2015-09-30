scrumAid.controller 'SprintsUpdateCtrl', [
  '$scope', '$modalInstance', 'Restangular', 'project', 'sprint', 'lastSprint', 'nextSprint'
  ($scope, $modalInstance, Restangular, project, sprint, lastSprint, nextSprint) ->
    
    init = () ->    
      $scope.datepickers = [
        {opened: false}
        {opened: false}
      ]   
      
      $scope.sprint = {
        name: sprint.name
        start_date: new Date(sprint.start_date)
        end_date: new Date(sprint.end_date)
        goal: sprint.goal
      }
      
      if lastSprint != undefined
        $scope.minDate = new Date(lastSprint.end_date)
      else 
        $scope.minDate = sprint.start_date
        
      if nextSprint != undefined
        $scope.maxDate = new Date(nextSprint.start_date)
      else 
        $scope.maxDate = undefined
      
    init()
    
    $scope.updateEndDate = () ->
      if $scope.sprint.start_date > $scope.sprint.end_date
        $scope.sprint.end_date = $scope.sprint.start_date
    
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')

    $scope.open = ($event, index) ->
      $scope.datepickers[index].opened = true

    $scope.update = () ->
      Restangular.one('projects', project._id.$oid).one('sprints').customPUT($scope.sprint, sprint._id.$oid).then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
]
