require 'open3'

# find list of all files committed in last commit and run specs for them
# cmd = 'git rev-parse HEAD'
# last_commit_id = Open3.popen3(cmd)  do |stdin, stdout, stderr, wait_thr|
#    stdout.read
# end
# puts last_commit_id
# str = "git diff-tree --no-commit-id --name-only -r "+last_commit_id
# puts str
# file_array = []
# file_names = Open3.popen3(str)  do |stdin, stdout, stderr, wait_thr|
#    file_array << stdout.read
# end
# file_names =  file_names[0].split("\n")

# spec_array = []
# file_names.each do |file_name|
#   ext = File.extname file_name
#   name = File.basename file_name, ext
#   spec_array << name+"_spec"+ext
# end
# spec_array.each do |spec_file|
#   puts "In spec array"
#   full_file_name = "rspec mongoid/"+spec_file
#   abc = Open3.popen3(full_file_name)  do |stdin, stdout, stderr, wait_thr|
#     stdout.read
#   end
#   puts abc
# end

# find list of all uncommitted files and run specs for only them
cmd = 'git status --untracked-files=no --porcelain'
file_names = []
file_names = Open3.popen3(cmd)  do |stdin, stdout, stderr, wait_thr|
  file_names << stdout.read
end
spec_files = []
file_names = file_names[0].split("\n")
file_names.each do |file_name|
  if file_name.include? "controllers" or file_name.include? "helpers" or file_name.include? "views" and !(file_name.include? "spec")
    file_name = file_name.partition('app').last
    puts file_name
    path = File.dirname file_name
    ext = File.extname file_name
    name = File.basename file_name, ext
    spec_files << "rspec spec"+ path + "/" + name + "_spec" + ext
  end
end
puts "Spec array"
puts spec_files
spec_files.each do |spec_file|
  system(spec_file)
end