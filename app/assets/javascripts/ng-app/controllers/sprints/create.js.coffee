scrumAid.controller 'SprintsCreateCtrl', [
  '$scope', '$modalInstance', 'Restangular', 'project', 'lastSprint'
  ($scope, $modalInstance, Restangular, project, lastSprint) ->
    
    init = () ->    
      $scope.datepickers = [
        {opened: false}
        {opened: false}
      ]   
      
      if lastSprint != undefined
        name = "Sprint " + (lastSprint.index + 1)
        startDate = new Date(lastSprint.end_date)
      else
        name = "Sprint 1"
        startDate = new Date()
        
      endDate = new Date(startDate)
      endDate.setDate(startDate.getDate() + project.sprint_length)
      
      $scope.sprint = {
        name: name
        start_date: startDate
        end_date: endDate
      }
      
      $scope.minDate = startDate
      
    init()
    
    $scope.updateEndDate = () ->
      if $scope.sprint.start_date > $scope.sprint.end_date
        $scope.sprint.end_date = $scope.sprint.start_date

    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')

    $scope.open = ($event, index) ->
      $scope.datepickers[index].opened = true

    $scope.create = () ->
      Restangular.one('projects', project._id.$oid).one('sprints').post('', {sprint: $scope.sprint}).then(
        (response) ->
          $modalInstance.close(response)
        (error) ->
          $modalInstance.close(error)
      )
]
