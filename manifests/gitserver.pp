class profiles::gitserver {

  git::git { 'git': 
    base_path =>  '/opt/repos/git',
  }

}
