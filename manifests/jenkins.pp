class profiles::jenkins {

  include ::git::client
  include ::jenkins
  include ::profiles::jenkins::testtools
  
  # gitlab-plugin and dependencies

  jenkins::plugin { 'git':
    version =>  'latest',
    before  => Jenkins::Plugin['git-client'],
  }
    
  jenkins::plugin { 'git-client':
    version =>  'latest',
    before  => Jenkins::Plugin['gitlab-plugin'],
  }
  
  jenkins::plugin { 'gitlab-plugin':
    version => 'latest',
  }

  jenkins::plugin { 'matrix-projects':
    version => latest,
    before  => Jenkins::Plugin['warnings'],
  }
  
  jenkins::plugin { 'analysis-core':
    version => latest,
    before  => Jenkins::Plugin['warnings'],
  }
  
  jenkins::plugin { 'warnings':
    version => latest,
  }
}
