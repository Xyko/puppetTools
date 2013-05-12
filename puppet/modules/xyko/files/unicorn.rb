worker_processes 2
working_directory "/home/xyko/xyko"

preload_app true

timeout 30

listen "/home/xyko/xyko/tmp/sockets/unicorn.sock", :backlog => 64

pid "/home/xyko/xyko/tmp/pids/unicorn.pid"

stderr_path "/home/xyko/xyko/log/unicorn.stderr.log"
stdout_path "/home/xyko/xyko/log/unicorn.stdout.log"

before_fork do |server, worker|
    defined?(ActiveRecord::Base) and
       ActiveRecord::Base.connection.disconnect!
    end

after_fork do |server, worker|
    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.establish_connection
    end
