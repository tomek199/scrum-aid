scrumAid.controller 'EventsIndexCtrl', [
  '$scope', '$routeParams', '$modal', 'Restangular'
  ($scope, $routeParams, $modal, Restangular) ->

    project = Restangular.one('projects', $routeParams.project_id)
            
    $scope.eventSources = []
    $scope.viewMode = {
      isCollapsed: true
      calendarClass: 'col-md-12'
      eventClass: ''
    }

    project.get().then(
      (response) ->
        $scope.project = response
    )
    
    project.getList('events').then(
      (response) -> 
        $scope.events = response
        $scope.eventSources.push($scope.events)
    )
    
    $scope.show = (data, jsEvent, view) ->
      $scope.viewMode = {
        isCollapsed: false
        calendarClass: 'col-md-10'
        eventClass: 'col-md-2'
      }
      
      $scope.selectedEvent = {
        title: data.title
        start: new Date(data.start)
        allDay: data.allDay
        description: data.description
      }
      $scope.selectedEvent.end = new Date(data.end) if !data.allDay
    
    $scope.close = () ->
      $scope.viewMode = {
        isCollapsed: true
        calendarClass: 'col-md-12'
        eventClass: ''
      }
      $scope.selectedEvent = null
    
    
    $scope.uiConfig = {
      calendar:
        editable: true
        header:
          left: 'month agendaWeek agendaDay'
          center: 'title'
          right: 'today prev,next'
        eventClick: $scope.show
    }
    
    $scope.new = () ->
      modalInstance = $modal.open
        templateUrl: 'events/add.html'
        controller: 'EventsCreateCtrl'
        size: 'lg'
        resolve:
          project_id: ->
            $scope.project._id.$oid
      modalInstance.result.then (result) ->
        if result._id?
          $scope.events.push(result)
]
