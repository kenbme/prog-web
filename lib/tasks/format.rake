namespace :format do
  task :ruby do
    cmd = "erb-format app/views/**/*.html.erb --write && standardrb --fix"
    system("bash", "-c", cmd)
  end
end
