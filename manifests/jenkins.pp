class profiles::jenkins {

  include git::client
  include jenkins
  
  # first step, experiment with git/github

  jenkins::plugin { 'git': }

  jenkins::plugin { ['promoted-builds', 'credentials', 'git-client',
                       'scm-api', 'mailer', 'token-macro', 'matrix-project',
                       'ssh-credentials', 'parameterized-trigger' ]: }

  jenkins::plugin { 'github': }
  jenkins::plugin { [ 'plain-credentials', 'github-api' ]: }

}
