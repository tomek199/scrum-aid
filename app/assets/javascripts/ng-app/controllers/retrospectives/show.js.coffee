scrumAid.controller 'RetrospectivesShowCtrl', [
  '$scope', '$modalInstance', 'Restangular', 'retrospective_id'
  ($scope, $modalInstance, Restangular, retrospective_id) ->
    
    init = () ->
      Restangular.one('retrospectives', retrospective_id).get().then(
        (response) ->
          $scope.retrospective = response
          $scope.count = 0
          $scope.done = 0
          $scope.type = 'default'
          if $scope.retrospective.ideas
            for idea in $scope.retrospective.ideas
              $scope.count++
              if idea.done
                $scope.done++
      )
      
    init()
    
    $scope.update = (index) ->
      done = $scope.retrospective.ideas[index].done
      $scope.retrospective.ideas[index].done = !done
      if done
        $scope.done--
      else
        $scope.done++
        
      Restangular.one('retrospectives').customPUT(retrospective: {ideas: $scope.retrospective}.ideas, retrospective_id).then(
        (response) ->
      )
      
    $scope.$watch('done', (newVal, oldVal) ->
      if newVal == $scope.count
        $scope.type = 'success'
      else
        $scope.type = 'default'
    )
    
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]
