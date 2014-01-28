# == Class: code_only
#
# creates code-only app deployment
#
class code_only (
  $user            = 'apache',
  $group           = 'apache',
) {

  include apache
  #  include deployment

  # create resources for all the code-only app's defined in hiera.
  $code_only_instances = hiera_hash('code_only_instances', undef)
  create_resources('code_only::instance', $code_only_instances)

}
