# puppet-module-code_only #


  * This module creates a directory located at $deploy_dir or /x01/www/html for deployed code.   
  * There is no corresponding ColdFusion instance


# Compatibility #

  * Note  that this module requires packages specific to Herff Jones and is not suitable for other parties.

  * EL 6 *
 
# Parameters #

  *  $user - defaults to "apache"

  *  $group - defaults to "apache"

  *  $deploy_dir - defaults to "null "
