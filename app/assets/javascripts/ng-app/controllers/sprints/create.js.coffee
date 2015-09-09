scrumAid.controller 'SprintsCreateCtrl', [
  '$scope', '$modalInstance',
  ($scope, $modalInstance) ->
#    $scope.sprint = {}
    $scope.datepickers = [
      {opened: false}
      {opened: false}
    ]

    $scope.cancel = () ->
      $modalInstance.dismiss('cancel')

    $scope.open = ($event, index) ->
      $scope.datepickers[index].opened = true
]
