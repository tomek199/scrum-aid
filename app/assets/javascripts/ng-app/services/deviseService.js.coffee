scrumAid.factory 'DeviseService', ($resource) ->

  # Current user
  _currentUser = null;

  # Sign up resource
  signUpResource = $resource '/users.json', {},
    post:
      method: 'POST'
      isArray: false

  # Sign in resource
  signInResource = $resource '/users/sign_in.json', {},
    post:
      method: 'POST'
      isArray: false

  # Sign up API
  signUp = (user, success, error) ->
    signUpResource.post(user: user).$promise.then(
      (response) ->
        signIn(user,
          (authResponse) ->
            success(_currentUser)
          (authResponse) ->
            error(authResponse)
        )
      (response) ->
        error(response)
    )

  # Sign in API
  signIn = (user, success, error) ->
    signInResource.post(user:user).$promise.then(
      (response) ->
        _currentUser = response
        success(_currentUser)
      (reponse) ->
        error(response)
    )

  # Current user API
  currentUser = () ->
    _currentUser


  # API return
  {
    signUp: signUp
    signIn: signIn
    currentUser: currentUser
  }