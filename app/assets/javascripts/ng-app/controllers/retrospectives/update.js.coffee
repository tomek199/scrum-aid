scrumAid.controller 'RetrospectivesUpdateCtrl', [
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
      )
      
      Restangular.one('retrospectives', $routeParams.retrospective_id).get().then(
        (response) ->
          $scope.retrospective = {
            name: response.name
            date: new Date(response.date)
            pluses: generateArray(response.pluses)
            minuses: generateArray(response.minuses)
            ideas: generateArray(response.ideas)
          }
      )
    
    init()
    
    generateArray = (array) ->
      if array
        return array
      else 
        return []
      
    $scope.open = ($vent) ->
      $scope.datepicker.opened = true
      
    $scope.back = () ->
      $location.path '/projects/' + $routeParams.project_id + '/sprints/' + $routeParams.sprint_id + '/retrospectives'
      
    $scope.update = () ->
      Restangular.one('retrospectives').customPUT(retrospective: $scope.retrospective, $routeParams.retrospective_id).then(
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
