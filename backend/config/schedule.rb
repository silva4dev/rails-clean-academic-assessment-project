set :runner_command, "rails runner"

every "0 0 1 * *" do
  runner "Application::Services::MonthlyClosureService.new.execute", output: { error: "log/cron-error.log", standard: "log/cron.log" }
end
