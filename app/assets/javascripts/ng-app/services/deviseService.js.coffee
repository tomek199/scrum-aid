scrumAid.service 'DeviseService', ($resource)->
  $resource '/users:action', {},
    signUp:
      method: 'POST'
      params:
        action: '.json'
      isArray: false
