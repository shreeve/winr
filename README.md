# winr

A quick and lightweight benchmarking tool for Ruby

## Goals

1. Provide a simple way to benchmark code
2. Easy to configure and compare results

## Overview

There are several tools for benchmarking Ruby code. Unfortunately, it's hard
to remember the way to set up the benchmarks, what format to use to represent
what to test, and how to perform the testing. One of the most popular tools
used for benchmarking Ruby code is `benchmark-driver`, which was used heavily
by the Ruby 3x3 team. It uses three levels of abstraction and is powerful,
but there is a lot of inconsistency in naming conventions and using the tool.

The idea of `winr` is to offer an easy to configure benchmarking tool that is
easy to use. There are three levels of abstraction:

* environments - An environment is an optional top-level container for running
  code. It can represent different versions Ruby, or different setup options
  that will be shared by any nested contexts or tasks.
* contexts - A context represents an optional mid-level container for running
  code. Any context configuration is shared by any contained tasks.
* tasks - A task represents a unit of work to be tested, within its optional
  containing context and optional containing environment.

Within an environment, context, or task, the following can be defined:

* name - The name of the element, to use when displaying output
* begin - Code that should be run before any contained elements
* end - Code that should run after any contained elements
* script - Code that is contained within a task
* loops - The number of times that a task's script should be executed
* warmup - An optional top-level setting that is used when the number of
  loops has not been defined. This value is the number of seconds to run
  the task before determining the number of loops that have run. The
  default value is 3 seconds, meaning that the number of loops is not
  defined, the task will be allowed to run for 3 seconds and the number
  of iterations during this time will be used.

## Examples

Configuration information is stored in a Ruby file, like the following:

```ruby
$ cat test/sum.rb

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

        max = 1e5.to_i
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
  warmup: 3,
}
```

The benchmark is run as follows:

```
$ winr test/sum.rb

┌──────────────────┬───────────────────────────────────────┐
│ Shiny new Ruby   │                Results                │
├──────────────────┼───────────┬─────────────┬─────────────┤
│ array splat      │   2.99  s │ 768.19  i/s │   1.30 ms/i │
│ times            │   7.86  s │ 292.33  i/s │   3.42 ms/i │
└──────────────────┴───────────┴─────────────┴─────────────┘

┌──────────────────┬───────────────────────────────────────┐
│ Old trusted Ruby │                Results                │
├──────────────────┼───────────┬─────────────┬─────────────┤
│ array splat      │   2.96  s │ 777.46  i/s │   1.29 ms/i │
│ times            │   7.73  s │ 297.19  i/s │   3.36 ms/i │
└──────────────────┴───────────┴─────────────┴─────────────┘

┌──────────────────┬─────────────────────────────────────┐
│ Rank             │             Performance             │
├──────────────────┼─────────────┬──────────────┬────────┤
│ array splat      │ 777.46  i/s │   fastest    │ 2/1/1  │
│ array splat      │ 768.19  i/s │ 1.01x slower │ 1/1/1  │
│ times            │ 297.19  i/s │ 2.62x slower │ 2/1/2  │
│ times            │ 292.33  i/s │ 2.66x slower │ 1/1/2  │
└──────────────────┴─────────────┴──────────────┴────────┘
```

## Install

Install via `rubygems` with:

```
gem install winr
```

## Options

```
$ winr -h

usage: winr [options] <dir ...>
    -c, --[no-]color                 Enable color output (default is true)
    -d, --debug                      Enable debug mode
    -h, --help                       Show help and command usage
    -i, --iterations <count>         Force the number of iterations for each task
    -r, --reverse                    Show contexts vertically and tasks horizontally
    -s, --stats                      Comma-separated list of stats (loops, time, ips, spi)
    -v, --verbose                    Show command, version details, and markdown backticks

Available statistics:

  ips      iterations per second
  loops    number of iterations
  spi      seconds for iteration
  time     time to run all iterations
```

## License

This software is licensed under terms of the MIT License.
