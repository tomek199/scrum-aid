scrumAid.controller 'RetrospectivesShowCtrl', [
  '$scope', '$modalInstance', 'retrospective'
  ($scope, $modalInstance, retrospective) ->
    
    $scope.retrospective = retrospective
    
    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')
]
