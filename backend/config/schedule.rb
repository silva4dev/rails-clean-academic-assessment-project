set :runner_command, "rails runner"
set :output, "log/cron#{Time.now.strftime('%Y%m%d')}.log"

every 1.minute do
  puts "OKKKKKKKKKKKKKKKKKK"
  runner "Rails.logger.info('Executando tarefa agendada a cada 1 minuto!')"
end
