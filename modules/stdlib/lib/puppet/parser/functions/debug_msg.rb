Puppet::Parser::Functions::newfunction(:debug_msg, :type => :statement, :doc => "
Send messages to a particular debug level
") do |vals|
  
  $level, $debug_message = vals
  $possible_levels = ["debug","info","notice","warning","err","alert","emerg","crit"]
  if $possible_levels.include? $level
  else
    raise(ArgumentError, 'Must specify proper debug type. It can be either "debug","info","notice","warning","err","alert","emerg" or "crit" ')
  end
  Puppet.send($level.to_sym, $debug_message)
end