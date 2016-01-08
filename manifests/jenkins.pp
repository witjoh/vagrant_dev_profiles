class profiles::jenkins {

  include git::client
  include jenkins
  
  # gitlab-plugin and dependencies

  jenkins::plugin { 'git':
    version =>  '2.4.1',
    before  => Jenkins::plugin['git-client'],
  }
    
  jenkins::plugin { 'git-client':
    version =>  '1.19.1',
    before  => Jenkins::plugin['gitlab-plugin'],
  }
  
  jenkins::plugin { 'gitlab-plugin':
    version => '1.1.28',
  }

  jenkins::plugin { 'matrix-projects':
    version => latest,
    before  => Jenkins::plugin['warnings'],
  }
  
  jenkins::plugin { 'analysis-core':
    version => latest,
    before  => Jenkins::plugin['warnings'],
  }
  
  jenkins::plugin { 'warnings':
    version => latest,
  }
}
