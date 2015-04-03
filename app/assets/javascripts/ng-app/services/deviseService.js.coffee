scrumAid.factory 'DeviseService', ($resource, $cookies) ->

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

  # Save sign in user data to cookie
  saveUser = (user) ->
    $cookies.currentUser = JSON.stringify(user)

  # Sign up API
  signUp = (user, success, error) ->
    signUpResource.post(user: user).$promise.then(
      (response) ->
        signIn(user,
          (authResponse) ->
            success(currentUser())
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
        saveUser(response)
        success(currentUser())
      (reponse) ->
        error(response)
    )

  # Current user API
  currentUser = () ->
    JSON.parse($cookies.currentUser)

  # Is authenticated API
  isAuthenticated = () ->
    !!$cookies.currentUser


  # API return
  {
    signUp: signUp
    signIn: signIn
    currentUser: currentUser
    isAuthenticated: isAuthenticated
  }