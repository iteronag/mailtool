#set the working application directory
working_directory "/var/www/mailtool/current"

# Unicorn PID file locationa
pid "/var/www/mailtool/current/tmp/pids/unicorn.pid"

# Path to logs
stderr_path "/var/www/mailtool/current/log/unicorn_error.log"
stdout_path "/var/www/mailtool/current/log/unicorn.log"

# Unicorn socket
listen "/var/www/mailtool/current/tmp/sockets/unicorn_production.sock"

preload_app true

# Number of processes
worker_processes 4

# Time-out
timeout 600

