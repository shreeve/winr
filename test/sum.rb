{
  environments: [
    {
      name: "Shiny new Ruby",
      command: "/opt/ruby-3.2.0/bin/ruby",
    },
    {
      name: "Old trusted Ruby",
      command: "/opt/ruby-2.7.6/bin/ruby",
    },
  ],
  contexts: [
    {
      begin: <<~"|",
        require "digest/md5"

        max = 5e4.to_i
      |
    },
    {
      begin: <<~"|",
        require "digest/md5"

        max = 1e3.to_i
      |
    },
  ],
  tasks: [
    {
      name: "array splat",
      script: <<~"|",
        ary = [*1..max]
        sum = ary.sum
      |
    },
    {
      name: "times",
      script: <<~"|",
        sum = 0
        max.to_i.times {|n| sum += n }
      |
    },
  ],
  warmup: 2,
}
