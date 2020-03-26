# profiles::editors::vim
#
# Profile to setup and configure vim as puppet development
# editor.
#
class profiles::tools::vim (
  Array[String,1]     = ['vagrant']
) {

  class{ "vim":
      user_list => ['vagrant'],
  }

}
