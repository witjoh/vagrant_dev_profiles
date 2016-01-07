class profiles::jenkins {

  include git::client
  include jenkins
  
  # gitlab-plugin and dependencies

  jenkins::plugin { 'git':
    version =>  '2.4.1',
  }
    
  jenkins::plugin { 'git-client':
    version =>  '1.19.1',
  }
  
  jenkins::plugin { 'gitlab-plugin':
    version => '1.1.28',
  }

}
