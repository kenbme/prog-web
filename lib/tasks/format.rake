namespace :format do
  task :ruby do
    cmd = "standardrb --fix && erb-format app/views/**/*.html.erb --write && npx prettier --write app/javascript/**/*.js --log-level error"
    system("bash", "-c", cmd)
  end
end
