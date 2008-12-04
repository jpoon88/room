namespace :cleanup do
  desc "Timestamp and copy all log files"
  task :archive do
    timestamp = Time.now.strftime('%y_%m_%d_%H_%M_%S')
    FileList["log/*.log"].each do |log_file|
      FileUtils.copy_file(log_file, "#{log_file}.#{timestamp}")
    end
  end

  desc "Truncates all *.log files in log/ to zero bytes"
  task :clear => :archive do
    FileList["log/*.log"].each do |log_file|
      f = File.open(log_file, "w")
      f.close
    end
  end
  
  desc "Active Record Test"
  task :test => :environment do
    puts Complex.find(:first)
  end
  
end