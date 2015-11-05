scrumAid.controller 'RetrospectivesCreateCtrl', [
  '$scope', '$routeParams', '$location', 'Restangular'
  ($scope, $routeParams, $location, Restangular) ->
    
    init = () ->
      $scope.datepicker = {opened: false}
      
      Restangular.one('projects', $routeParams.project_id).get().then(
        (response) ->
          $scope.project = response
      )
      
      Restangular.one('sprints', $routeParams.sprint_id).get().then(
        (response) ->
          $scope.sprint = response
          $scope.retrospective = {
            date: new Date($scope.sprint.end_date)
            name: $scope.sprint.name + ' retrospective'
            pluses: []
            minuses: []
            ideas: []
          }
      )
    
    init()
      
    $scope.open = ($vent) ->
      $scope.datepicker.opened = true
      
    $scope.back = () ->
      $location.path '/projects/' + $routeParams.project_id + '/sprints/' + $routeParams.sprint_id + '/retrospectives'
      
    $scope.create = () ->
      Restangular.one('sprints', $routeParams.sprint_id).one('retrospectives').post('', {retrospective: $scope.retrospective}).then(
        (response) ->
          $scope.back()
      )
      
    $scope.checkName = (data) ->
      if !data
        return "Can't be blank"

    # Pluses actions
      
    $scope.addPlus = () ->
      $scope.temp = {description: '', isNew: true}
      $scope.retrospective.pluses.push($scope.temp.description)
      
    $scope.cancelPlus = (index) ->
      if $scope.temp
        $scope.retrospective.pluses.splice(index, 1)
      $scope.temp = null
    
    $scope.savePlus = (data, index) -> 
      $scope.retrospective.pluses[index] = data.description
      $scope.temp = null
      return
    
    $scope.deletePlus = (index) ->
      $scope.retrospective.pluses.splice(index, 1)
      
    # Minuses actions
      
    $scope.addMinus = () ->
      $scope.temp = {description: '', isNew: true}
      $scope.retrospective.minuses.push($scope.temp.description)
    
    $scope.cancelMinus = (index) ->
      if $scope.temp
        $scope.retrospective.minuses.splice(index, 1)
      $scope.temp = null
  
    $scope.saveMinus = (data, index) -> 
      $scope.retrospective.minuses[index] = data.description
      $scope.temp = null
      return
  
    $scope.deleteMinus = (index) ->
      $scope.retrospective.minuses.splice(index, 1)
      
    # Ideas actions
      
    $scope.addIdea = () ->
      $scope.temp = {idea: {description: '', done: false}, isNew: true}
      $scope.retrospective.ideas.push($scope.temp.idea)
    
    $scope.cancelIdea = (index) ->
      if $scope.temp
        $scope.retrospective.ideas.splice(index, 1)
      $scope.temp = null
  
    $scope.saveIdea = (data, index) -> 
      $scope.retrospective.ideas[index] = data
      $scope.temp = null
      return
  
    $scope.deleteIdea = (index) ->
      $scope.retrospective.ideas.splice(index, 1)
]
