p ARGV.replace ["file1"]
p ARGF.readlines # Returns the contents of file1 as an Array
p ARGV #=> []
p ARGV.replace ["file2", "file3"]
p ARGF.read # Returns the contents of file2 and file3
